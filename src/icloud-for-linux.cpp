#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setApplicationName("icloud-for-linux." + QString(argv[1]));

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/icloud-for-linux.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
