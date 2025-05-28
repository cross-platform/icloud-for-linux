#include <gui/choc_WebView.h>

#include <gui/choc_DesktopWindow.h>
#include <gui/choc_MessageLoop.h>

#include <filesystem>
#include <fstream>

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

    choc::ui::DesktopWindow appWin( choc::ui::Bounds{ 0, 0, 0, 0 } );
    appWin.setVisible( false );
    appWin.centreWithSize( 1000, 600 );
    appWin.setVisible( true );
    appWin.setWindowTitle( "iCloud " + std::string( argv[2] ) );
    appWin.windowClosed = []() { choc::messageloop::stop(); };

    choc::ui::WebView::Options webViewOptions;
    webViewOptions.customUserAgent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.7123.45 Safari/537.36";
    choc::ui::WebView webView( webViewOptions );
    webView.navigate( "https://www.icloud" + tld + "/" + std::string( argv[1] ) );

    appWin.setContent( webView.getViewHandle() );
    appWin.toFront();

    webView.onNewWindow( [&argv]( const std::string& url ) {
        choc::ui::DesktopWindow appWin2( choc::ui::Bounds{ 0, 0, 0, 0 } );
        appWin2.setVisible( false );
        appWin2.centreWithSize( 1000, 600 );
        appWin2.setVisible( true );
        appWin2.setWindowTitle( "iCloud " + std::string( argv[2] ) + " ⧉" );

        choc::ui::WebView::Options webView2Options;
        webView2Options.customUserAgent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.7123.45 Safari/537.36";
        choc::ui::WebView webView2( webView2Options );
        webView2.navigate( url );

        appWin2.setContent( webView2.getViewHandle() );
        appWin2.toFront();

        return appWin2.getWindowHandle();
    } );

    choc::messageloop::run();
    return 0;
}
