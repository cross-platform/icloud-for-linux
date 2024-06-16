#include <gui/choc_WebView.h>
#include <gui/choc_DesktopWindow.h>
#include <gui/choc_MessageLoop.h>

int main(int, char **argv)
{
    choc::ui::DesktopWindow appWin(choc::ui::Bounds{0, 0, 0, 0});
    appWin.centreWithSize(1000, 600);
    appWin.setWindowTitle( "iCloud " + std::string(argv[2]) );
    appWin.windowClosed = []()
    { choc::messageloop::stop(); };

    choc::ui::WebView webView;
    webView.navigate("https://www.icloud.com/" + std::string(argv[1]));

    appWin.setContent(webView.getViewHandle());
    appWin.toFront();

    webView.onNewWindow( [&](const std::string& url)
    {
        choc::ui::DesktopWindow appWin(choc::ui::Bounds{0, 0, 0, 0});
        appWin.centreWithSize(1000, 600);
        appWin.setWindowTitle( "iCloud " + std::string(argv[2]) + " ⧉" );

        choc::ui::WebView webView;
        webView.navigate(url);

        appWin.setContent(webView.getViewHandle());
        appWin.toFront();

        return appWin.getWindowHandle();
    });

    choc::messageloop::run();
    return 0;
}
