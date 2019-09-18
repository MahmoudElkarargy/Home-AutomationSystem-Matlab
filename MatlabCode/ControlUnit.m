function varargout = ControlUnit(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ControlUnit_OpeningFcn, ...
                   'gui_OutputFcn',  @ControlUnit_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ControlUnit is made visible.
function ControlUnit_OpeningFcn(hObject, eventdata, handles, varargin)

handles.b = Bluetooth('HC-05',1);
fopen(handles.b);

handles.output = hObject;

guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = ControlUnit_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


% --- Executes on button press in Room1p1.
function Room1p1_Callback(hObject, eventdata, handles)

LightOn = imread('LightOn.jpg');
fwrite(handles.b,'1','uchar');
uiwait(msgbox({'Room 1';' light ON'},'Success','custom',LightOn));



% --- Executes on button press in Room1p2.
function Room1p2_Callback(hObject, eventdata, handles)
LightOFF = imread('LightOFF.jpg');
fwrite(handles.b,'2','uchar');
uiwait(msgbox({'Room 1';' light OFF'},'Success','custom',LightOFF));


% --- Executes on button press in Room2p2.
function Room2p2_Callback(hObject, eventdata, handles)
LightOFF = imread('LightOFF.jpg');
fwrite(handles.b,'4','uchar');
uiwait(msgbox({'Room 2';' light OFF'},'Success','custom',LightOFF));


% --- Executes on button press in Room2p1.
function Room2p1_Callback(hObject, eventdata, handles)
LightOn = imread('LightOn.jpg');
fwrite(handles.b,'3','uchar');
uiwait(msgbox({'Room 2';' light ON'},'Success','custom',LightOn));


% --- Executes on button press in Door1.
function Door1_Callback(hObject, eventdata, handles)
DoorOpen = imread('DoorOpen.jpg');
fwrite(handles.b,'5','uchar');
uiwait(msgbox({'The Door'; 'is now opened'},'Success','custom',DoorOpen));



% --- Executes on button press in Door2.
function Door2_Callback(hObject, eventdata, handles)
DoorClosed = imread('DoorClosed.jpg');
fwrite(handles.b,'6','uchar');
uiwait(msgbox({'The Door';' is now closed'},'Success','custom',DoorClosed));
