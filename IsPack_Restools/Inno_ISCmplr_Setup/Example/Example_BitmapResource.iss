; 演示如何使用Setup参数 BitmapResource.
; 脚本: restools ( http://restools.hanzify.org )

; 该参数主要给安装程序添加 Bitmap 资源, 这样做主要可以为卸载程序带来额外的图像资源.
; 因为卸载程序是不带压缩文件的. 所以如果想卸载程序也是一个单独的文件, 只能以资源方式为卸载程序提供额外的图像来源.

#ifndef IS_ENHANCED
  #error Enhanced edition of Inno Setup (restools) is required to compile this script
#endif

[Setup]
AppName=My Program
AppVersion=1.5
DefaultDirName={pf}\My Program
DefaultGroupName=My Program
UninstallDisplayIcon={app}\MyProg.exe
SolidCompression=yes
Compression=lzma/ultra
OutputDir=userdocs:Inno Setup Examples Output
BitmapResource=MyBmp1:2000.bmp|MyBmp2:2001.bmp|MyBmp3:2002.bmp
; BitmapResource 格式:
;  BmpResName1:BmpFileName1|BmpResName2:BmpFileName2|BmpResName3:BmpFileName3|......
; 注意: Bitmap 资源写入安装程序后, 会自动在 Bitmap 资源名称前面添加前缀 "_IS_"
; 所以在使用 Bitmap.LoadFromResourceName 等等函数的时候也需要在图标资源名称前面添加 "_IS_"
; 例如: Bitmap.LoadFromResourceName(HInstance, '_IS_MYBMP1');

; HInstance 在增强版中也会同时提供, 方便引用安装程序自身的资源.

; 以下的例子虽然是在安装程序中演示, 但是它也同样适用于卸载程序.

[Code]
procedure InitializeWizard();
var
  MyIco1, MyIco2, MyIco3: TBitmapImage;
begin
  with TLabel.Create(WizardForm) do
  begin
    Parent := WizardForm.WelcomePage;
    Caption := 'MyBmp1:';
    SetBounds(ScaleX(176), ScaleY(184), ScaleX(45), ScaleY(13));
  end;
  with TLabel.Create(WizardForm) do
  begin
    Parent := WizardForm.WelcomePage;
    Caption := 'MyBmp2:';
    SetBounds(ScaleX(248), ScaleY(184), ScaleX(45), ScaleY(13));
  end;
  with TLabel.Create(WizardForm) do
  begin
    Parent := WizardForm.WelcomePage;
    Caption := 'MyBmp3:';
    SetBounds(ScaleX(320), ScaleY(184), ScaleX(45), ScaleY(13));
  end;

  MyIco1 := TBitmapImage.Create(WizardForm);
  with MyIco1 do
  begin
    Parent := WizardForm.WelcomePage;
    SetBounds(ScaleX(176), ScaleY(200), 32, 32);
    // HInstance 是新提供的返回安装程序实例的函数, 它主要是配合安装程序或卸载程序调用自身资源使用的.
    Bitmap.LoadFromResourceName(HInstance, '_IS_MYBMP1');
  end;
  MyIco2 := TBitmapImage.Create(WizardForm);
  with MyIco2 do
  begin
    Parent := WizardForm.WelcomePage;
    SetBounds(ScaleX(248), ScaleY(200), 32, 32);
    Bitmap.LoadFromResourceName(HInstance, '_IS_MYBMP2');
  end;
  MyIco3 := TBitmapImage.Create(WizardForm);
  with MyIco3 do
  begin
    Parent := WizardForm.WelcomePage;
    SetBounds(ScaleX(320), ScaleY(200), 32, 32);
    Bitmap.LoadFromResourceName(HInstance, '_IS_MYBMP3');
  end;

  WizardForm.WelcomeLabel2.Height := ScaleY(100);
end;





