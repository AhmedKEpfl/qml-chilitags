#include "fileio.h"
#include <QObject>
#include <QFile>
#include <QTextStream>

FileIO::FileIO()
{

}

void FileIO::save(QString text){
    QFile file("test.txt");

    if(file.open(QIODevice::ReadWrite)){
        QTextStream stream(&file);
        stream << text << endl;
    }

    return;

}

QString FileIO::read(){
    {
        QFile file("test.txt");
        QString fileContent;
        if ( file.open(QIODevice::ReadOnly) ) {
            QString line;
            QTextStream t( &file );
            do {
                line = t.readLine();
                fileContent += line;
                fileContent += '\n';
             } while (!line.isNull());

            file.close();
        } else {
            return QString();
        }
        return fileContent;
    }
}

FileIO::~FileIO()
{

}

