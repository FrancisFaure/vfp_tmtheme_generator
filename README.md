
# A Visual FoxPro theme for **Visual Studio Code**

* Microsoft Visual Studio Code website: https://code.visualstudio.com/
* Visual FoxPro language Extension website: [GitHub](https://github.com/FrancisFaure/vfp_tmlanguage_generator)



## VFP Theme generator: Personalize your VS Code Theme (with VFP Extension for VS Code)

* If you want have more colors or personalize your theme:

Download [vfp_tmtheme_generator.prg](https://github.com/FrancisFaure/vfp_tmtheme_generator), personalize, run in vfp9, and click "Ok" to install.

After, you can see :

![THEME](images/Screen-to-gif.gif)


## Uninstall

**vfp_tmtheme_generator.prg** : create a uninstaller script file : **"vfp_tmtheme\uninstall vfp theme.cmd"**
* who contains:
```
rd /S/Q %USERPROFILE%\.vscode\extensions\Theme-Dark-vfp\
```
(or remove %USERPROFILE%\.vscode\extensions\Theme-Dark-vfp\ with Windows explorer)


## License

[MIT](LICENSE) &copy; Francis FAURE




** Enjoy! **