* Francis FAURE
* Generate a theme for VS Code
* January 2016
* VS Code URL : https://code.visualstudio.com/
clear
set exact on

#define C_CRLF chr(13) + chr(10)
#define C_TAB  chr(9)

#define C_LANGUAGE                         "vfp"
#define C_TMTHEME_FILENAME                 "vfp.tmTheme"
#define C_PACKAGE_JSON_FILENAME            "package.json"
#define C_UNINSTALL_FILENAME               "uninstall vfp theme.cmd"
#define C_OUTPUT_DIR                       addbs(justpath(sys(16,0))) + "vfp_tmtheme\"
#define C_MESSAGEBOX_TITLE                 "Personalized VS Code Theme for Visual FoxPro"
* 0.1.1 Initial Commit
* 0.1.2 utf8( ) function updated by "akvalibra"
#define C_VERSION                          "0.1.2"

local lsxml as string
lsxml = ""

lsxml = m.lsxml + C_TAB + "<key>name</key>" + C_CRLF
lsxml = m.lsxml + C_TAB + "<string>" + C_LANGUAGE + "</string>" + C_CRLF
lsxml = m.lsxml + C_TAB + "<key>settings</key>" + C_CRLF
lsxml = m.lsxml + C_TAB + "<array>" + C_CRLF
*-------------------------------- Personalize your favorite colors here :
lsxml = m.lsxml + xml_theme("Comments",         "#008000")
lsxml = m.lsxml + xml_theme("Commands",         "#569cd6", "bold")
lsxml = m.lsxml + xml_theme("Functions",        "#569cd6", "italic")
lsxml = m.lsxml + xml_theme("Tokens",           "#569cd6")
lsxml = m.lsxml + xml_theme("Classes",          "#f112e9", "bold")
lsxml = m.lsxml + xml_theme("Types",            "#f112e9", "italic")
lsxml = m.lsxml + xml_theme("Operators",        "#ffff00")
lsxml = m.lsxml + xml_theme("Constants",        "#ffff00", "bold")
lsxml = m.lsxml + xml_theme("Strings",          "#ffae00")
lsxml = m.lsxml + xml_theme("Numerics",         "#2aff00")
lsxml = m.lsxml + xml_theme("System Variables", "#f112e9")
lsxml = m.lsxml + xml_theme("Variables",        "#b121d5", "bold")
lsxml = m.lsxml + xml_theme("Macro",            "#ffae00", "bold")
lsxml = m.lsxml + xml_theme("Meta",             "#569cd6")
*--------------------------------
lsxml = m.lsxml + C_TAB + "</array>" + C_CRLF
lsxml = xml_theme_Header_Footer(m.lsxml)
lsxml = utf8(m.lsxml)

if CreateFile(C_TMTHEME_FILENAME, m.lsxml) and ;
    CreateFile(C_PACKAGE_JSON_FILENAME, theme_package_json())
  ? "DONE"
  if install_theme()
    =CreateFile(C_UNINSTALL_FILENAME, "rd /S/Q %USERPROFILE%\.vscode\extensions\Theme-Dark-vfp\")
    =messagebox("OK : Restart your VS Code !", 0, C_MESSAGEBOX_TITLE)
  endif
endif

return


function xml_theme(lsKeyWord as string,;
    lsForeground as string,;
    lsFontstyle as string) as string
  local lsReturn as string
  lsReturn = replicate(C_TAB, 2)+ "<dict>" + C_CRLF
  lsReturn = m.lsReturn + replicate(C_TAB, 3)+ "<key>name</key>" + C_CRLF
  lsReturn = m.lsReturn + replicate(C_TAB, 3)+ "<string>" + m.lsKeyWord + "</string>" + C_CRLF
  lsReturn = m.lsReturn + replicate(C_TAB, 3)+ "<key>scope</key>" + C_CRLF
  local lsScope as string
  lsScope = ""
  do case
    case upper(m.lsKeyWord) == "COMMENTS"
      lsScope = "comment"
    case upper(m.lsKeyWord) == "COMMANDS"
      lsScope = "support.other"
    case upper(m.lsKeyWord) == "FUNCTIONS"
      lsScope = "support.function, entity.name.function"
    case upper(m.lsKeyWord) == "TOKENS"
      lsScope = "keyword"
    case upper(m.lsKeyWord) == "CLASSES"
      lsScope = "support.class, entity.name.class, entity.name.type.class"
    case upper(m.lsKeyWord) == "TYPES"
      lsScope = "support.type"
    case upper(m.lsKeyWord) == "OPERATORS"
      lsScope = "keyword.operator"
    case upper(m.lsKeyWord) == "CONSTANTS"
      lsScope = "constant.language, support.constant"
    case upper(m.lsKeyWord) == "STRINGS"
      lsScope = "string.quoted.single, string.quoted.double, string.quoted.triple, string"
    case upper(m.lsKeyWord) == "NUMERICS"
      lsScope = "constant.numeric"
    case upper(m.lsKeyWord) == "SYSTEM VARIABLES"
      lsScope = "variable.language"
    case upper(m.lsKeyWord) == "VARIABLES"
      lsScope = "variable.other, variable.parameter, variable"
    case upper(m.lsKeyWord) == "META"
      lsScope = "meta"
    case upper(m.lsKeyWord) == "MACRO"
      lsScope = "string.interpolated"
    otherwise
      ? "keyword unknown: " + m.lsKeyWord
      cancel
  endcase
  lsReturn = m.lsReturn + replicate(C_TAB, 3)+ "<string>" + m.lsScope + "</string>" + C_CRLF
  lsReturn = m.lsReturn + replicate(C_TAB, 3)+ "<key>settings</key>" + C_CRLF
  lsReturn = m.lsReturn + replicate(C_TAB, 3)+ "<dict>" + C_CRLF
  lsReturn = m.lsReturn + replicate(C_TAB, 4)+ "<key>foreground</key>" + C_CRLF
  lsReturn = m.lsReturn + replicate(C_TAB, 4)+ "<string>" +m.lsForeground + "</string>" + C_CRLF
  if !empty(m.lsFontstyle)
    lsReturn = m.lsReturn + replicate(C_TAB, 4)+ "<key>fontStyle</key>" + C_CRLF
    lsReturn = m.lsReturn + replicate(C_TAB, 4)+ "<string>" +m.lsFontstyle + "</string>" + C_CRLF
  endif
  lsReturn = m.lsReturn + replicate(C_TAB, 3)+ "</dict>" + C_CRLF
  lsReturn = m.lsReturn + replicate(C_TAB, 2)+ "</dict>" + C_CRLF
  return m.lsReturn
  return


function xml_theme_Header_Footer(lsString as string) as string
  * header
  lsString = ;
    [<?xml version="1.0" encoding="UTF-8"?>] + C_CRLF + ;
    [<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">] + C_CRLF + ;
    [<plist version="1.0">] + C_CRLF + ;
    [<dict>] + C_CRLF + ;
    m.lsString
  * footer
  lsString = m.lsString + ;
    C_TAB + "<key>uuid</key>" + C_CRLF + ;
    C_TAB + "<string>7F151E0F-DE68-49B8-B4EE-BA16A0EED90A</string>" + C_CRLF + ;
    "</dict>" + C_CRLF + ;
    "</plist>" + C_CRLF
  return m.lsString
endfunc

function CreateFile(lsFilename as string, lsString as string) as Logical
  local llReturn as Logical
  llReturn = .t.
  try
    if !directory(C_OUTPUT_DIR)
      md C_OUTPUT_DIR
    endif
    =DeleteFileIfExist(C_OUTPUT_DIR + m.lsFilename)
    =strtofile(m.lsString, C_OUTPUT_DIR + m.lsFilename, 0)
    ? "Generate " + C_OUTPUT_DIR + m.lsFilename
  catch
    llReturn = .f.
    ? "ERROR-----------------------"
    ? message()
    cancel
  endtry
  return m.llReturn
endfunc

procedure DeleteFileIfExist(lsFilename as string)
  if file(m.lsFilename)
    erase (m.lsFilename)
  endif
endproc

function utf8(m.lsString as string) as string
  * return strconv(strconv(m.lsString, 1),9) && "akvalibra" update
  return strconv(m.lsString,9)
endfunc

function theme_package_json() as string
  local lsReturn as string
  local lsLanguage as string
  lsLanguage = C_LANGUAGE
  local tmLanguage as string
  tmTheme = C_TMTHEME_FILENAME
  local lsVersion as string
  lsVersion = C_VERSION
  set textmerge delimiters
  text TO m.lsReturn NOSHOW TEXTMERGE
{
	"name": "theme-<<m.lsLanguage>>",
	"displayName": "theme-<<m.lsLanguage>>",
	"description": "VS Code Theme for Visual FoxPro.",
	"version": "<<m.lsVersion>>",
	"publisher": "Francis FAURE",
	"engines": {
		"vscode": "^0.10.1"
	},
	"categories": [
		"Themes"
	],
	"contributes": {
		"themes": [
			{
			"label": "Dark (Visual FoxPro)",
			"scopeName": "source.<<m.lsLanguage>>",
			"path": "./themes/<<m.tmTheme>>"
			}
		]
	}
}
  ENDTEXT
  return utf8(m.lsReturn)
endfunc

* return .T. if installed
function install_theme() as Logical
  local llReturn as Logical
  llReturn = .f.
  if file(C_OUTPUT_DIR + C_TMTHEME_FILENAME) and ;
      file(C_OUTPUT_DIR + C_PACKAGE_JSON_FILENAME)
    local lsVSCodeExtensionDir as string
    lsVSCodeExtensionDir = getenv("USERPROFILE") + "\.vscode\extensions\"
    if directory(m.lsVSCodeExtensionDir)
      if messagebox("Install now ?", 4+32, C_MESSAGEBOX_TITLE) == 6 && YES
        try
          if !directory(m.lsVSCodeExtensionDir)
            md (m.lsVSCodeExtensionDir)
          endif
          if !directory(m.lsVSCodeExtensionDir + "Theme-Dark-vfp")
            md (m.lsVSCodeExtensionDir + "Theme-Dark-vfp")
          endif
          =DeleteFileIfExist(m.lsVSCodeExtensionDir + "Theme-Dark-vfp\" + C_PACKAGE_JSON_FILENAME)
          copy file (C_OUTPUT_DIR + C_PACKAGE_JSON_FILENAME) to (m.lsVSCodeExtensionDir + "Theme-Dark-vfp")

          if !directory(m.lsVSCodeExtensionDir + "\Theme-Dark-vfp\themes")
            md (m.lsVSCodeExtensionDir + "Theme-Dark-vfp\themes")
          endif
          =DeleteFileIfExist(m.lsVSCodeExtensionDir + "Theme-Dark-vfp\themes\" + C_TMTHEME_FILENAME)
          copy file (C_OUTPUT_DIR + C_TMTHEME_FILENAME) to (m.lsVSCodeExtensionDir + "Theme-Dark-vfp\themes")
          llReturn = .t.
        catch
          ? "ERROR-----------------------"
          ? message()
          cancel
        endtry
      endif
    else
      ? "VS Code not installed on this computer (" + m.lsVSCodeExtensionDir + ": not found)"
    endif
  endif
  return m.llReturn
endfunc
