#include <QtGui/QApplication>
#include <QtCore/QLocale>
#include <QtCore/QTranslator>
#include <QtCore/QDebug>
#include <QtCore/QLibraryInfo>
#include "qmlapplicationviewer.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QT_TRANSLATE_NOOP("QApplication", "QT_LAYOUT_DIRECTION"); // RTL or LTR

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
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/Prayers/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
