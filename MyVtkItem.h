#include <QQuickVTKItem.h>
#include <QVTKRenderWindowAdapter.h>

#include <vtkActor.h>
#include <vtkCamera.h>
#include <vtkCapsuleSource.h>
#include <vtkConeSource.h>
#include <vtkPolyDataMapper.h>
#include <vtkRenderWindow.h>
#include <vtkRenderWindowInteractor.h>
#include <vtkRenderer.h>
#include <vtkRendererCollection.h>

#include <QtQml/QQmlApplicationEngine>
#include <QtQml/QQmlContext>
#include <QtQml/qqmlregistration.h>
#include <vtkSphereSource.h>
#include <vtkOBJReader.h>

struct MyVtkItem : QQuickVTKItem {
    Q_OBJECT
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)
    QML_ELEMENT
public:
    MyVtkItem();

    struct Data : vtkObject {
        static Data* New();
        vtkTypeMacro(Data, vtkObject);

        vtkNew<vtkActor> actor;
        vtkNew<vtkRenderer> renderer;
        vtkNew<vtkConeSource> cone;
        vtkNew<vtkSphereSource> sphere;
        vtkNew<vtkCapsuleSource> capsule;
        vtkNew<vtkPolyDataMapper> mapper;
    };

    vtkUserData initializeVTK(vtkRenderWindow* renderWindow) override;
    void destroyingVTK(vtkRenderWindow* renderWindow, vtkUserData userData) override;

    void resetCamera();
    void dispatchChangedSource();
    Q_INVOKABLE void readFile(QUrl path);

    // Q_PROPERTY(QString file READ file WRITE setFile NOTIFY fileChanged)
    QString source() const { return _source; }
    void setSource(QString v);

    bool event(QEvent* ev) override;

signals:
    void sourceChanged(QString);
    void clicked();

private:
    QString _source;
    vtkNew<vtkCamera> _camera;
    QScopedPointer<QMouseEvent> _click;
};
