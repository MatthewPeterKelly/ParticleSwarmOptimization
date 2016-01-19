function output = mergeOptions(default, user,name)
% output = mergeOptions(default, user, name)
%
% Merge a default options struct with a user-defined options struct. Works
% recursively, and will issue warning messages if the user attempts to
% define a field that is not in the default options.
%
% BEHAVIOR:
% 
% - All fields in DEFAULT will be present in OUTPUT
% - If a field is in both DEFAULT and USER, then the value from USER is
% present in OUTPUT
% - If a field is present in USER, but not DEFAULT, then issue a warning.
% - Applies recursively
%
%
% NOTES:
%
%   The argument NAME is optional, and contains a string specifying the
%   name of the options struct. This is primarily used for printing
%   warnings to the user.
%
%   This function works recursively. For example, if there is a struct
%   inside of a struct, then it will recursively apply this merge.
%

%%%% Start by assuming that the OUTPUT is just the DEFAULT
output = default;

if nargin == 2
    structName = '';
else
    structName = [name '.'];
end

if ~isempty(user)
    
    %%%% Check for any overriding fields in the USER-defined struct
    default_fields = fieldnames(default);
    for i=1:length(default_fields)
        if isfield(user,default_fields{i})
            C0 = isstruct(default.(default_fields{i}));
            C1 = isstruct(user.(default_fields{i}));
            if C0 && C1  % Both are structs
                output.(default_fields{i}) = mergeOptions(...
                    default.(default_fields{i}),...
                    user.(default_fields{i}),...
                    [structName default_fields{i}]);
            elseif ~C0 && ~C1  % Both are fields
                output.(default_fields{i}) = user.(default_fields{i});
            elseif C0 && ~C1  %default is struct, user is a field
                 disp(['WARNING: ' structName default_fields{i} ' should be a struct!']);     
            elseif ~C0 && C1  %default is struct, user is a field
                 disp(['WARNING: ' structName default_fields{i} ' should not be a struct!']);
            end
        end
    end
    
    %%%% Check for any fields in USER that are not in DEFAULT
    user_fields = fieldnames(user);
    for i=1:length(user_fields)
        if ~isfield(default, user_fields{i})
            disp(['WARNING: unrecognized option: ' structName user_fields{i}]);
        end
    end
    
end

end