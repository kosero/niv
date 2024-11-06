import ui, os

proc saveText(textbox: MultilineEntry, FileName: string) =
  writeFile(FileName, textbox.text)

proc main*() =
  let args = commandLineParams()

  var FileName: string
  if args.len < 1:
    FileName = "untitled.txt"
    writeFile(FileName, "")
  else:
    FileName = args[0]

  if not fileExists(FileName):
    echo "#[error]: file not found: ", FileName
    quit 1

  var MW: Window
  let textbox = newMultilineEntry()
 
  var menu = newMenu("File")
  menu.addItem("Open", proc() =
    let filename = ui.openFile(MW)
    if filename.len == 0:
      msgBoxError(MW, "No file selected", "Don't be alarmed!")
    else:
      textbox.text = readFile(filename)
  )
  
  menu.addItem("Save", proc() =
    let filename = ui.saveFile(MW)
    if filename.len == 0:
      msgBoxError(MW, "No file selected", "Don't be alarmed!")
    else:
      saveText(textbox, filename)
  )

  menu.addQuitItem(proc(): bool {.closure.} =
    MW.destroy()
    return true)

  MW = newWindow("Niv", 640, 480, true)
  MW.margined = true
  MW.onClosing = (proc (): bool = return true)

  let box = newVerticalBox(true)
  MW.setChild(box)

  try:
    textbox.text = readFile(FileName)
  except IOError:
    textbox.text= ""
    quit 1

  textbox.onChanged = proc() = saveText(textbox, FileName)
  box.add(textbox, true)

  show(MW)
  mainLoop()

init()
main()

