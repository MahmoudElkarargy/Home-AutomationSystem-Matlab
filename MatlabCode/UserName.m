function varargout = UserName(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UserName_OpeningFcn, ...
                   'gui_OutputFcn',  @UserName_OutputFcn, ...
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


% --- Executes just before UserName is made visible.
function UserName_OpeningFcn(hObject, eventdata, handles, varargin)

set(handles.Check, 'UserData', 0);

% Choose default command line output for UserName
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


function varargout = UserName_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;




function UserName_Callback(hObject, eventdata, handles)
    str = get(hObject, 'String');
    popChoice = str(get(hObject,'Value'));
    if(strcmp(popChoice,'Guest')) 
        popValue =1;    
    elseif(strcmp(popChoice,'Sam'))
        popValue =2;
    elseif(strcmp(popChoice,'Maya'))
        popValue =3;
    else
        popValue =0;
    end
    setappdata(handles.UserName, 'yourVariable', popValue);



function Check_Callback(hObject, eventdata, handles)
   pass = str2num(get(handles.Password,'string'));
   yourVariable = getappdata(handles.UserName , 'yourVariable')
   set(handles.Text,'string','');
   pause(0.1)
   counter = get(hObject, 'UserData')
       if(counter == 2)
           set(handles.Text,'string','SYSTEM IS CLOSED');
           pause(2);
           close(UserName);   
       else
            if (yourVariable == 1)
                if(pass == 1234)
                    set(handles.Text,'string','Welcome Guest');
                    run('ControlUnit.m');
                    close(UserName);
                else
                    set(handles.Text,'string','Wrong password Guest');
                    counter = get(hObject, 'UserData') + 1;
                    set(hObject, 'UserData', counter);
                end
            elseif(yourVariable == 2)
                if(pass == 1111)
                    set(handles.Text,'string','Welcome Sam');
                    run('ControlUnit.m');
                    close(UserName);
                else
                    set(handles.Text,'string','Wrong password Sam');
                    counter = get(hObject, 'UserData') + 1;
                    set(hObject, 'UserData', counter);
                end
            elseif(yourVariable == 3)
                if(pass == 0000)
                    set(handles.Text,'string','Welcome Maya');
                    run('ControlUnit.m');
                    close(UserName);
                else
                    set(handles.Text,'string','Wrong password Maya');
                    counter = get(hObject, 'UserData') + 1;
                    set(hObject, 'UserData', counter);
                end
            end
       end
  
        
% --- Executes during object creation, after setting all properties.
function UserName_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Password_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function Password_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
