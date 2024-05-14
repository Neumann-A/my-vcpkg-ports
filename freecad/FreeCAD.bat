SET script_path=%~dp0
SET prefix_path=%script_path%/../../../
SET PATH=%prefix_path%/tools/Qt6/bin;%prefix_path%/tools/python3/DLLs;%PATH%
SET PYTHONPATH=%prefix_path%/tools/python3/Lib;%prefix_path%/tools/python3/Lib/site-packages

set QT3D_RENDERER=opengl
set QSG_RHI_BACKEND=opengl

FreeCAD.exe