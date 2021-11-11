#include <QKeyEvent>
#include <QWebEngineView>
#include <QGuiApplication>

#include "remapkeys.h"

RemapKeys::RemapKeys(QObject *parent) : QObject(parent)
{
    mRemapKeys = {
        {109, 24},
        {122, 25},
        {119, 26},
        {105, 28},
        {103, 30},
        {124, 31},
        {125, 32},
        {107, 33},
        {121, 34},
        {126, 35},
        {120, 38},
        {127, 39},
        {102, 40},
        {100, 41},
        {115, 42},
        {106, 47},
        {129, 48},
        {131, 52},
        {123, 53},
        {117, 54},
        {112, 55},
        {108, 56},
        {118, 57},
        {128, 58},
        {101, 59},
        {130, 60},
        {132, 49},
        {104, 46},
        {110, 27},
        {113, 29},
        {119, 26},
        {115, 42},
        {116, 43},
        {114, 44},
        {111, 45}
    };
}


bool RemapKeys::event(QEvent *event)
{
    return QObject::event(event);
}


bool RemapKeys::eventFilter(QObject *watched, QEvent *event)
{
    if (event->type() == QEvent::KeyRelease || event->type() == QEvent::KeyPress) {
         QKeyEvent* key = static_cast<QKeyEvent*>(event);
         if(nullptr != key && key->nativeVirtualKey() > 2000)
         {
              auto currentKey = key->nativeScanCode();
              if ( auto it{ mRemapKeys.find(currentKey) }; it != std::end(mRemapKeys) )
              {
                  QCoreApplication::postEvent(watched, new QKeyEvent(
                                  key->type(), key->key(), key->modifiers(),
                                  mRemapKeys[currentKey], key->nativeVirtualKey(),
                                  key->nativeModifiers(), key->text(),
                                  key->isAutoRepeat(), key->count()
                              ));
                  return true;
              }

         }
    }
    return QObject::eventFilter(watched, event);
}
