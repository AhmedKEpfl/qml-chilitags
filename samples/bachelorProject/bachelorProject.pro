TEMPLATE = app

QT += qml quick core gui network webkit
CONFIG += c++11

SOURCES += main.cpp \
    fileio.cpp

RESOURCES += qml.qrc

INCLUDEPATH +=

LIBS += -lchilitags

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH +=


# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    fileio.h

DESTDIR = $$PWD
