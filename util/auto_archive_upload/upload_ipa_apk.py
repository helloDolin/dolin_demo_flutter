import requests
import time

api_key = '3d441ecf39e37e8e74a2d491b2eff3c3'

# buildType：ipa（iOS）
# apk（Android）


def _getToken(callback=None, buildType='ipa'):
    '''' 获取上传 token '''
    data = {
        '_api_key': api_key,
        'buildType': buildType
    }
    print("获取TOKE中...")
    try:
        r = requests.post(
            'https://www.pgyer.com/apiv2/app/getCOSToken', data=data)
        if r.status_code == requests.codes.ok:
            result = r.json()
            print(f"获取TOKEN成功：{result}")
            if callback is not None:
                callback(True, result)
        else:
            print(f"获取TOKEN失败：{result}")
            if callback is not None:
                callback(False, None)
    except Exception as e:
        print(f"获取TOKEN失败：{e}")


def _getBuildInfo(api_key, json, callback=None):
    """
    检测应用是否发布完成，并获取发布应用的信息
    """
    time.sleep(3)  # 先等个几秒，上传完直接获取肯定app是还在处理中~
    response = requests.get('https://www.pgyer.com/apiv2/app/buildInfo', params={
        '_api_key': api_key,
        'buildKey': json['data']['params']['key'],
    })
    if response.status_code == requests.codes.ok:
        result = response.json()
        code = result['code']
        if code == 1247 or code == 1246:  # 1246 应用正在解析、1247 应用正在发布中，再次调用
            _getBuildInfo(api_key=api_key, json=json, callback=callback)
        else:
            if callback is not None:
                callback(True, result)
    else:
        if callback is not None:
            callback(False, None)


def upload(path, callback=None):
    ''' 
    上传到蒲公英
    path：文件路径
    '''
    def getCOSToken_callback(isSuccess, json):
        if isSuccess:
            _upload_url = json['data']['endpoint']
            files = {'file': open(path, 'rb')}
            headers = {'enctype': 'multipart/form-data'}
            payload = json['data']['params']
            print("iPa包上传中...")

            try:
                r = requests.post(_upload_url, data=payload,
                                  files=files, headers=headers)

                if r.status_code == 204:
                    print("iPa包上传成功，正在获取包信息，请稍等...")
                    _getBuildInfo(api_key=api_key, json=json,
                                  callback=callback)
                else:
                    print(f"iPa包上传失败 {r}")
                    print('HTTPError,Code:' + str(r.status_code))
                    if callback is not None:
                        callback(False, None)
            except requests.exceptions.RequestException as e:
                print(f'iPa包上传失败：{e}')
        else:
            pass
    _getToken(buildType='ipa', callback=getCOSToken_callback)


def upload_complete_callback(isSuccess, result):
    print(result)
    if isSuccess:
        print('上传完成')
        _data = result['data']
        # 去除首尾空格
        _url = f'https://www.pgyer.com/{_data["buildShortcutUrl"].strip()}'
        _appVer = _data['buildVersion']
        _buildVer = _data['buildBuildVersion']
        _buildQRCodeURL = _data['buildQRCodeURL']
        _buildCreated = _data['buildCreated']
        print(f'链接: {_url}')
        print(f'版本: {_appVer} (build {_buildVer})')
        print(f'二维码链接: {_buildQRCodeURL}')
        print(f'构建时间: {_buildCreated}')

        # send_dingTalk(_url, _buildQRCodeURL, _appVer, _buildCreated)
    else:
        print('上传失败')


def main():
    print('---upload---begin')
    upload(upload_complete_callback)


if __name__ == '__main__':
    main()
