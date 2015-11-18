TEMPLATE = app

QT += qml quick
CONFIG += c++11

SOURCES += main.cpp \
    fileio.cpp

RESOURCES += qml.qrc

INCLUDEPATH += /home/ahmed/Documents/epfl/bachelorProject/chilitagsStuff/chilitags/include

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    fileio.h

DESTDIR = $$PWD
