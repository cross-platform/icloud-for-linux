#include <gui/choc_WebView.h>

#include <gui/choc_DesktopWindow.h>
#include <gui/choc_MessageLoop.h>

#include <filesystem>
#include <fstream>

constexpr const char* USER_AGENT = "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:125.0) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Safari/605.1.15";

choc::ui::DesktopWindow createWindow( const std::string& title, const std::string& url )
{
    choc::ui::DesktopWindow window( choc::ui::Bounds{ 0, 0, 0, 0 } );

    window.setVisible( false );
    window.centreWithSize( 1000, 600 );
    window.setVisible( true );
    window.setWindowTitle( title );

    choc::ui::WebView::Options webViewOptions;
    webViewOptions.customUserAgent = USER_AGENT;
    choc::ui::WebView webView( webViewOptions );
    webView.navigate( url );

    window.setContent( webView.getViewHandle() );
    window.toFront();

    return window;
}

int main( int, char** argv )
{
    std::string tld = ".com";

    const char* snapCommon = getenv( "SNAP_USER_COMMON" );
    if ( snapCommon != nullptr && snapCommon[0] != 0 )
    {
        std::filesystem::path tldPath( std::filesystem::path( snapCommon ) / "tld" );
        if ( std::filesystem::exists( tldPath ) )
        {
            std::ifstream tldIs( tldPath );
            tld = std::string( ( std::istreambuf_iterator<char>( tldIs ) ), {} );
            tldIs.close();
        }
    }

    choc::ui::DesktopWindow appWin = createWindow( "iCloud " + std::string(argv[2]), "https://www.icloud" + tld + "/" + std::string(argv[1]) );
    appWin.windowClosed = []() { choc::messageloop::stop(); };

    appWin.onNewWindow( [&argv]( const std::string& url ) {
        choc::ui::DesktopWindow appWin2 = createWindow( "iCloud " + std::string(argv[2]) + " ⧉", url );
        return appWin2.getWindowHandle();
    });

    choc::messageloop::run();
    return 0;
}

