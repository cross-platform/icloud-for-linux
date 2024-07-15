#include <gui/choc_WebView.h>
#include <gui/choc_DesktopWindow.h>
#include <gui/choc_MessageLoop.h>

#include <filesystem>
#include <fstream>
#include <iostream>
#include <string>
#include <cstdlib>

std::string getTLD() {
    const char* tldEnv = getenv("ICLOUD_TLD");
    if (tldEnv && tldEnv[0] != '\0') {
        return std::string(tldEnv);
    }

    const char* snapCommon = getenv("SNAP_USER_COMMON");
    if (snapCommon && snapCommon[0] != '\0') {
        std::filesystem::path tldPath(std::filesystem::path(snapCommon) / "tld");
        if (std::filesystem::exists(tldPath)) {
            std::ifstream tldIs(tldPath);
            if (tldIs) {
                std::string tld((std::istreambuf_iterator<char>(tldIs)), {});
                tldIs.close();
                return tld;
            }
        }
    }

    return ".com"; // Default TLD
}

int main( int argc, char** argv ) {
    try {
        if (argc < 3) {
            throw std::invalid_argument("Insufficient arguments. Usage: <program> <page> <title>");
        }

        std::string tld = getTLD();

        choc::ui::DesktopWindow appWin( choc::ui::Bounds{ 0, 0, 0, 0 } );
        appWin.setVisible( false );
        appWin.centreWithSize( 1000, 600 );
        appWin.setVisible( true );
        appWin.setWindowTitle( "iCloud " + std::string( argv[2] ) );
        appWin.windowClosed = []() { choc::messageloop::stop(); };

        choc::ui::WebView::Options webViewOptions;
        webViewOptions.customUserAgent = "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:125.0) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Safari/605.1.15";
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
            webView2Options.customUserAgent = "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:125.0) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Safari/605.1.15";
            choc::ui::WebView webView2( webView2Options );
            webView2.navigate( url );

            appWin2.setContent( webView2.getViewHandle() );
            appWin2.toFront();

            return appWin2.getWindowHandle();
        });
        choc::messageloop::run();
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return EXIT_FAILURE;
    } catch (...) {
        std::cerr << "Unknown error occurred\n" << std::endl;
        return EXIT_FAILURE;
    }

    return 0;
}
