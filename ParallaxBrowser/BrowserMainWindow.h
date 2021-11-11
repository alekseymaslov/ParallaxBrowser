/*
 * Copyright 2021 <copyright holder> <email>
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef BROWSERMAINWINDOW_H
#define BROWSERMAINWINDOW_H


#include <QMainWindow>
#include <QWebEngineView>
#include <QWebEngineFullScreenRequest>

/**
 * @todo write docs
 */
class BrowserMainWindow : public QMainWindow
{
     Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = nullptr);

private slots:
    void fullScreenRequested(QWebEngineFullScreenRequest request);

private:
    QWebEngineView *m_view;
    QScopedPointer<FullScreenWindow> m_fullScreenWindow;
};

#endif // BROWSERMAINWINDOW_H
