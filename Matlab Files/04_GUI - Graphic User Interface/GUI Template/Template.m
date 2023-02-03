function varargout = Template(varargin)
% TEMPLATE MATLAB code for Template.fig
%      TEMPLATE, by itself, creates a new TEMPLATE or raises the existing
%      singleton*.
%
%      H = TEMPLATE returns the handle to a new TEMPLATE or the handle to
%      the existing singleton*.
%
%      TEMPLATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEMPLATE.M with the given input arguments.
%
%      TEMPLATE('Property','Value',...) creates a new TEMPLATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Template_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Template_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES



% ---------------------Unsere fig beinhaltet folgende handler:
% edit_path
% btn_browse 
% radiobutton_col
% radiobutton_row
% edit_col
% edit_row
% edit_header_col
% edit_header_row
% btn_execute
% ------------------------

% Edit the above text to modify the response to help Template

% Last Modified by GUIDE v2.5 21-Aug-2018 14:12:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Template_OpeningFcn, ...
                   'gui_OutputFcn',  @Template_OutputFcn, ...
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


% --- Executes just before Template is made visible.
function Template_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Template (see VARARGIN)

% Choose default command line output for Template
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Template wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Template_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
 
% --- Executes on button press in btn_browse.
function btn_browse_Callback(hObject, eventdata, handles)
% hObject    handle to btn_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[fileNameCSV, pathNameCSV] = uigetfile( ...
{  '*.csv',  'CSV Files (*.csv)'; ... ...
   '*.*',  'All Files (*.*)'}, ...
   'Select CSV Path');

set(handles.edit_path, 'String', [pathNameCSV, fileNameCSV]);

function edit_path_Callback(hObject, eventdata, handles)
% hObject    handle to edit_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_path as text
%        str2double(get(hObject,'String')) returns contents of edit_path as a double


% --- Executes during object creation, after setting all properties.
function edit_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_header_col_Callback(hObject, eventdata, handles)
% hObject    handle to edit_header_col (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_header_col as text
%        str2double(get(hObject,'String')) returns contents of edit_header_col as a double


% --- Executes during object creation, after setting all properties.
function edit_header_col_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_header_col (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_header_row_Callback(hObject, eventdata, handles)
% hObject    handle to edit_header_row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_header_row as text
%        str2double(get(hObject,'String')) returns contents of edit_header_row as a double


% --- Executes during object creation, after setting all properties.
function edit_header_row_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_header_row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_col_Callback(hObject, eventdata, handles)
% hObject    handle to edit_col (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_col as text
%        str2double(get(hObject,'String')) returns contents of edit_col as a double


% --- Executes during object creation, after setting all properties.
function edit_col_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_col (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_row_Callback(hObject, eventdata, handles)
% hObject    handle to edit_row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_row as text
%        str2double(get(hObject,'String')) returns contents of edit_row as a double


% --- Executes during object creation, after setting all properties.
function edit_row_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in btn_execute.
function btn_execute_Callback(hObject, eventdata, handles)
% hObject    handle to btn_execute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%CSV Path and Name from fileNameCSV, pathNameCSV

if strcmp(get(handles.edit_path, 'String'), '<Select Path>')
        
    warndlg('No CSV File Selected','No input');   
              
else 
    
    header_col = str2double(get(handles.edit_header_col, 'String'));
    header_row = str2double(get(handles.edit_header_row, 'String'));
    
       %------Check which RadioButton is active---------
       if (get(handles.radiobutton_col,'Value') == 1 )

           radio_state = 1
           %radio_col = (get(handles.radiobutton_col,'Value'))

       elseif (get(handles.radiobutton_row,'Value') == 1 )

           radio_state = 2
           %radio_row = (get(handles.radiobutton_row,'Value'))
    
       end
       
    % Sorting after which RadioButton is active   
    switch radio_state
       
        case 1 % Sort by column  
            
            col = str2double(get(handles.edit_col, 'String'))
            
        case 2 % Sort by row
            
            row = str2double(get(handles.edit_row, 'String'))       
    end  
       
end
