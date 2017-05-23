function [requiredFields,optionalFields] = getDefinedFieldProperties()
%GETDEFINEDFIELDPROPERTIES returns the Fields defined in the COBRA Toolbox
%along with checks for their properties 
%
% The returned Cell arrays are structured as follows:
% X{:,1} are the field names
% X{:,2} are the associated fields for the first dimension (i.e.
%        size(model.(X{A,1}),1) == size(model.(X{A,2}),1) has to evaluate
%        to true
% X{:,3} are the associated fields for the second dimension (i.e.
%        size(model.(X{A,1}),2) == size(model.(X{A,2}),1) has to evaluate
%        to true
% X{:,4} are evaluateable statements, which have to evaluate to true for
%        the model to be valid, these mainly check the content types.
%        E.g. 
%               x = model.(X{A,1});
%               eval(X{A,4}) has to return 1
% 
% X{:,5} are datatypes contained in the fields.
% X{:,6} are Descriptions of the fields.
%
% USAGE [requiredFields,optionalFields] = getDefinedFieldProperties()
%OUTPUTS
% requiredFields        The fields a model must have in order to be a valid
%                       COBRA Toolbox model
% optionalFields        The Fields which are supported by the COBRA
%                       Toolbox.
%
requiredFields = ...
    {'S','mets','rxns','isnumeric(x) || issparse(x)','Sparse or Full Matrix of Double','The stoichiometric matrix containing the model structure (for large models a sparse format is suggested)';...    
    'b','mets',1,'isnumeric(x)','Column Vector of Doubles','The coefficients of the constraints of the metabolites.';...
    'csense','mets',1,'ischar(x)','Column Vector of Chars','The sense of the constraints represented by b, each row is either E (equality), L(less than) or G(greater than)';...
    'lb','rxns',1,'isnumeric(x)','Column Vector of Doubles','The lower bounds for fluxes through the reactions.';...
    'ub','rxns',1,'isnumeric(x)','Column Vector of Doubles','The upper bounds for fluxes through the reactions.';...
    'c','rxns',1,'isnumeric(x)','Column Vector of Doubles ', 'The objective coefficient of the reactions.';...
    'osense',1,1,'isnumeric(x)','Double ', 'The objective sense either -1 for maximisation or 1 for minimisation';...
    'rxns','rxns',1,'iscell(x) && ~any(cellfun(@isempty, x)) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings ', 'Identifiers for the reactions.';...
    'mets','mets',1,'iscell(x) && ~any(cellfun(@isempty, x)) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings ', 'Identifiers of the metabolites';...
    'genes','genes',1,'iscell(x) && ~any(cellfun(@isempty, x)) && all(cellfun(@(y) ischar(y) , x))',' Column Cell Array of Strings', 'Identifiers of the genes in the model';...
    'rules','rxns',1,'iscell(x) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings', 'GPR rules in evaluateable format for each reaction ( e.g. "x(1) &#124; x(2) & x(3)", would indicate the first gene or the second and third gene from genes)'
    };



optionalFields = ...
    {'metCharges','mets',1,'isnumeric(x)','Column Vector of Double', 'The charge of the respective metabolite (NaN if unknown)';...
    'metFormulas','mets',1,'iscell(x) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings', 'Elemental formula for each metabolite';...
    'metSmiles','mets',1,'iscell(x) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings', 'Formula for each metabolite in SMILES Format';...
    'metNames','mets',1,'iscell(x) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings', 'Full name of each corresponding metabolite';...
    'metNotes','mets',1,'iscell(x) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings', 'Description of each corresponding metabolite';...
    'metHMDBID','mets',1,'iscell(x) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings', 'HMDBID of each corresponding metabolite';...
    'metInChIString','mets',1,'iscell(x) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings', 'InChI string of each corresponding metabolite';...
    'metKEGGID','mets',1,'iscell(x) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings', 'KEGG id of each corresponding metabolite';...    
    'description',NaN,NaN,'ischar(x) || isstruct(x)','String or Struct', 'Name of a file the model is loaded from' ;...
    'modelVersion',NaN,NaN,'isstruct(x)',' Struct', 'Model Version/History';...
    'geneNames','gene',1,'iscell(x) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings', 'Full name of each corresponding gene';...
    'grRules','rxns',1,'iscell(x) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings', 'A string representation of the GPR rules defined in rules';...
    'rxnGeneMat','rxns','genes','issparse(x) || isnumeric(x) || islogical(x)','Sparse or Full Matrix of Double or Boolean', 'A matrix that is 1 at position i,j if reaction i is associated with gene j';...
    'rxnConfidenceScores','rxns',1,'isnumeric(x) || iscell(x) && isnumeric(cellfun(str2num,x))','Column Vector of double', 'Confidence scores for reaction presence (0-4, with 4 being the highest confidence)';...
    'rxnNames','rxns',1,'iscell(x) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings', 'Full name of each corresponding reaction';...
    'rxnNotes','rxns',1,'iscell(x) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings', 'Description of each corresponding reaction';...
    'rxnECNumbers','rxns',1,'iscell(x) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings', 'EC Number of each corresponding reaction';...
    'rxnKEGGID','rxns',1,'iscell(x) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings', 'KEGG ID of each corresponding reaction';...
    'subSystems','rxns',1,'iscell(x) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings', 'subSystem assignment for each reaction';...    
    'compNames','comps',1,'iscell(x) && all(cellfun(@(y) ischar(y) , x))',' Column Cell Array of Strings', 'Full names of the compartments';...    
    'comps','comps',1,'iscell(x) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings', 'Identifiers of the compartments used in the metabolite names';...
    'proteinNames','proteins',1,'iscell(x) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings', 'Full name of each corresponding protein';...    
    'proteins','proteins',1,'iscell(x) && all(cellfun(@(y) ischar(y) , x))','Column Cell Array of Strings', 'ID for each protein'
    };
    		

function [fieldData] = addField(sourceList,fieldName,xdimension,ydimension,fieldCheck,fieldType,Description)
sourceList(end+1,:) = {fieldName,xdimension,ydimension,fieldCheck,fieldType,Description};
fieldData = sourceList;
