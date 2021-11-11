# ParallaxBrowser
The Web browser for mobian PinePnone

For build:

install:

gcc g++ make cmake qt5-qmake qtbase5-dev libqt5web* qml-module-qtwebengine  qml-module-qtquick2 qml-module-qtquick-controls2 qml-module-qtquick-controls qml-module-qtquick-controls2 qml-module-qtwebview qtwebengine5-dev

mkdir -p build
cd build
qmake .. CONFIG+=release
make
