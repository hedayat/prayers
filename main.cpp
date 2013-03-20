/*
 *  Prayers, Islamic prayer time application
 *  Copyright (C) 2013  Hedayat Vatankhah <gmail email: hedayatv>
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#include <QtGui/QApplication>
#include <QtCore/QLocale>
#include <QtCore/QTranslator>
#include <QtCore/QDebug>
#include <QtCore/QLibraryInfo>
#include <QDeclarativeContext>
#include "qmlapplicationviewer.h"
#include "setting.h"


void myMessageOutput(QtMsgType type, const char *msg)
{
    switch (type) {
    case QtDebugMsg:
        fprintf(stderr, "Debug: %s\n", msg);
        break;
    case QtWarningMsg:
        fprintf(stderr, "Warning: %s\n", msg);
        break;
    case QtCriticalMsg:
        fprintf(stderr, "Critical: %s\n", msg);
        break;
    case QtFatalMsg:
        fprintf(stderr, "Fatal: %s\n", msg);
        abort();
    }
}

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QT_TRANSLATE_NOOP("QApplication", "QT_LAYOUT_DIRECTION"); // RTL or LTR

//    qInstallMsgHandler(myMessageOutput);

    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QString locale = QLocale::system().name();

    QTranslator translator;
    if (translator.load("prayers_"+locale, ":/"))
        app->installTranslator(&translator);

    QTranslator qtTranslator;
    qtTranslator.load("qt_" + QLocale::system().name(),
            QLibraryInfo::location(QLibraryInfo::TranslationsPath));
    app->installTranslator(&qtTranslator);

    QmlApplicationViewer viewer;
    Settings settings("Prayers", "settings.ini");
    viewer.rootContext()->setContextProperty("settings", &settings);

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/Prayers/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
