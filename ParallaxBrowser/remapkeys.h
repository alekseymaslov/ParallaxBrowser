#ifndef REMAPKEYS_H
#define REMAPKEYS_H

#include <QObject>
#include <QString>
#include <map>

class RemapKeys : public QObject
{
    std::map<quint32, quint32> mRemapKeys;

    Q_OBJECT
public:
    explicit RemapKeys(QObject *parent = nullptr);

    virtual bool event(QEvent *event) override;
    virtual bool eventFilter(QObject *watched, QEvent *event) override;
signals:

};

#endif // REMAPKEYS_H
