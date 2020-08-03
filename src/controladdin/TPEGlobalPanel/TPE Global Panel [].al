controladdin "TPE Global Panel"
{
    RequestedHeight = 300;
    MinimumHeight = 300;
    MaximumHeight = 300;
    RequestedWidth = 700;
    MinimumWidth = 700;
    MaximumWidth = 700;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;
    // Scripts =
    //     'script1.js',
    //     'script2.js';
    //StyleSheets =
    //    'style.css';
    StartupScript = 'src/startupScript.js';
    // RecreateScript = 'recreateScript.js';
    // RefreshScript = 'refreshScript.js';
    // Images = 
    //     'image1.png',
    //     'image2.png';

    event HeartBeat();
    event GlobalPanelIsReady();
}