function varargout = GUI_Vergleich_ORI(varargin)
% GUI_VERGLEICH_ORI MATLAB code for GUI_Vergleich_ORI.fig
%      GUI_VERGLEICH_ORI, by itself, creates a new GUI_VERGLEICH_ORI or raises the existing
%      singleton*.
%
%      H = GUI_VERGLEICH_ORI returns the handle to a new GUI_VERGLEICH_ORI or the handle to
%      the existing singleton*.
%
%      GUI_VERGLEICH_ORI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_VERGLEICH_ORI.M with the given input arguments.
%
%      GUI_VERGLEICH_ORI('Property','Value',...) creates a new GUI_VERGLEICH_ORI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Vergleich_ORI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Vergleich_ORI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Vergleich_ORI

% Last Modified by GUIDE v2.5 20-Jan-2017 13:01:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Vergleich_ORI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Vergleich_ORI_OutputFcn, ...
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


% --- Executes just before GUI_Vergleich_ORI is made visible.
function GUI_Vergleich_ORI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Vergleich_ORI (see VARARGIN)

% Choose default command line output for GUI_Vergleich_ORI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Vergleich_ORI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Vergleich_ORI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function edit_path_vector_Callback(hObject, eventdata, handles)
% hObject    handle to edit_path_vector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_path_vector as text
%        str2double(get(hObject,'String')) returns contents of edit_path_vector as a double


% --- Executes during object creation, after setting all properties.
function edit_path_vector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_path_vector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_browse_vector.
function btn_browse_vector_Callback(hObject, eventdata, handles)
% hObject    handle to btn_browse_vector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileNameVector, pathNameVector] = uigetfile( ...
{  '*.mat',  'mat-Files (*.mat)'; ... ...
   '*.*',  'All Files (*.*)'}, ...
   'Select Orientation Vector');

set(handles.edit_path_vector, 'String', [pathNameVector, fileNameVector]);

function edit_vector_nr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vector_nr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vector_nr as text
%        str2double(get(hObject,'String')) returns contents of edit_vector_nr as a double


% --- Executes during object creation, after setting all properties.
function edit_vector_nr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vector_nr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_x_manuell_Callback(hObject, eventdata, handles)
% hObject    handle to edit_x_manuell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_x_manuell as text
%        str2double(get(hObject,'String')) returns contents of edit_x_manuell as a double


% --- Executes during object creation, after setting all properties.
function edit_x_manuell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_x_manuell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_y_manuell_Callback(hObject, eventdata, handles)
% hObject    handle to edit_y_manuell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_y_manuell as text
%        str2double(get(hObject,'String')) returns contents of edit_y_manuell as a double


% --- Executes during object creation, after setting all properties.
function edit_y_manuell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_y_manuell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_z_manuell_Callback(hObject, eventdata, handles)
% hObject    handle to edit_z_manuell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_z_manuell as text
%        str2double(get(hObject,'String')) returns contents of edit_z_manuell as a double


% --- Executes during object creation, after setting all properties.
function edit_z_manuell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_z_manuell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Auswahl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Auswahl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in btn_execute.
function btn_execute_Callback(hObject, eventdata, handles)
% hObject    handle to btn_execute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

exe=get(handles.Auswahl,'SelectedObject');
selection_rbtn=get(exe,'String'); % Nimmt den String der als Radiobutton deklariert wurde

switch selection_rbtn
    case 'Werte aus Vektor laden (.mat)' 
       
        c=1;
        
            if strcmp(get(handles.edit_path_vector, 'String'), '<None>')

                warndlg('No input Vector selected','No input');  

            elseif strcmp(get(handles.edit_vector_nr, 'String'), '<Nr.>')
               
                warndlg('No Nr. selected','No input');  

                
            else
                
               nr=str2num(get(handles.edit_vector_nr, 'String'));
                
               filepath = get(handles.edit_path_vector, 'String');
        
               load (filepath)
              
               ang_eul=TCP_ori{1,nr};
               
               func_Plot_Eulerwinkel(ang_eul)
               
            end
        
    case 'Werte manuell eingeben [Deg]'
        
        c=2

       func_Test_ob_String_nummer(get(handles.edit_x_manuell,'String')) % Test ob String nummer ist sonst Fehlermeldung
       func_Test_ob_String_nummer(get(handles.edit_y_manuell,'String'))
       func_Test_ob_String_nummer(get(handles.edit_z_manuell,'String'))
            

       
           x_Value=str2num(get(handles.edit_x_manuell,'String'));
           y_Value=str2num(get(handles.edit_y_manuell,'String'));
           z_Value=str2num(get(handles.edit_z_manuell,'String'));
           
           ang_eul=[x_Value, y_Value, z_Value];
        
           func_Plot_Eulerwinkel(ang_eul)
           
     end

% --- Executes on button press in btn_clear.
function btn_clear_Callback(hObject, eventdata, handles)
% hObject    handle to btn_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
