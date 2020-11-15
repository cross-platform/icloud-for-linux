QT += quick
SOURCES += src/icloud-for-linux.cpp
RESOURCES += src/icloud-for-linux.qrc

target.files += icloud-for-linux
target.path += $$[prefix]/bin
INSTALLS += target
