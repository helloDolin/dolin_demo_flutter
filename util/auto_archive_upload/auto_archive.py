import subprocess
import getpass
import datetime
import upload_ipa_apk as PgyUtil
import os

# 项目目录
workspace_path = '/Users/bd/Desktop/iOS'

# 导出文件存放地址 这里存放在桌面
export_root_path = f'/Users/{getpass.getuser()}/Desktop/archiveFile/'

# 项目名称（xcworkspace 前的名称）
project_name = 'AIEra'

# 项目scheme   xcodebuild -list  查看   scheme和项目名称不一定一样，所以这里分别配置
scheme = 'AIEra'

# 显示名字 用于发送钉钉时显示的名字
display_name = '钉钉消息显示的app名称'

# 项目完整路径
workspace = f'{workspace_path}/{project_name}.xcworkspace'

# 导出选项文件
export_options_plist = 'exportOptions.plist'

# 运行模式 debug release
configuration = 'release'

# method development ad-hoc appstore
method = 'ad-hoc'

# 导出路径（到日期）
export_path = f'{export_root_path}{project_name}/{datetime.datetime.now().strftime("%Y-%m-%d")}/'

# archive 路径
archive_path = export_path + project_name

# ipa 路径
ipa_path = export_path + 'export'


def clean_project():

    # xcworkspace项目clean
    # ${workspace} 工程中,.xcworkspace的文件名字
    # ${scheme} 当前要编译运行的scheme
    # configuration ${Debug或者Release} 当前是要以Debug运行还是以Release运行
    # -quiet 忽略警告提示打印
    # -UseNewBuildSystem=NO 是否使用新的build系统
    cmd = f'xcodebuild clean -workspace {workspace} -scheme {scheme} -configuration {configuration}'
    print(f'😄😄😄 cmd:{cmd}')
    process = subprocess.Popen(cmd, shell=True)
    process.wait()
    if process.returncode == 0:
        print(f'{project_name}.xcworkspace clean success!')
    else:
        print('clean 失败')


def build_project():
    ''' 构建项目 '''
    cmd = f'xcodebuild -workspace {workspace} -scheme {scheme} -configuration {configuration} -destination generic/platform=iOS build '
    print(f'😄😄😄 cmd:{cmd}')
    process = subprocess.Popen(cmd, shell=True)
    process.wait()
    if process.returncode == 0:
        print(f'{project_name}.xcworkspace build success!')
    else:
        print('build 失败')


def archive_project():
    ''' 打包项目 '''
    cmd = f'xcodebuild -workspace {workspace} -scheme {scheme} -configuration {configuration} -archivePath {archive_path} -destination generic/platform=iOS archive'
    print(f'😄😄😄 cmd:{cmd}')
    process = subprocess.Popen(cmd, shell=True)
    process.wait()
    if process.returncode == 0:
        print('archive 成功')
    else:
        print(f'archive失败:{workspace}')


def export_project():
    ''' 导出项目 '''
    archive_file = archive_path + '.xcarchive'
    cmd = f'xcodebuild -exportArchive -archivePath {archive_file} -exportPath {ipa_path} -exportOptionsPlist {export_options_plist} -allowProvisioningUpdates'
    print(f'😄😄😄 cmd:{cmd}')
    process = subprocess.Popen(cmd, shell=True)
    process.wait()
    if process.returncode == 0:
        print('导出archive 成功')
    else:
        print(f'导出archive失败:{workspace}')


def get_ipafile():
    ''' 获取ipa文件 '''
    # 遍历ipa_path文件夹，获取.ipa文件
    file_list = os.listdir(ipa_path)
    for file in file_list:
        if file.endswith('.ipa'):
            cur_path = os.path.join(ipa_path, file)
            return cur_path


def main():
    clean_project()
    build_project()
    archive_project()
    export_project()
    ipa_file = get_ipafile()
    if ipa_file:
        PgyUtil.upload(
            path=ipa_file, callback=PgyUtil.upload_complete_callback)


if __name__ == '__main__':
    main()
