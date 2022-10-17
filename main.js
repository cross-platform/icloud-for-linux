const { app, BrowserWindow, Menu, shell } = require('electron')

const appName = 'iCloud' 
const appUrl = 'https://www.icloud.com/'

function createWindow() {
  Menu.setApplicationMenu(null)

  const mainWindow = new BrowserWindow({
    width: 1000,
    height: 600,
    title: appName
  })

  mainWindow.loadURL(appUrl + process.argv[2])

  mainWindow.webContents.on('will-navigate', (event, url) => {
    if (!url.startsWith(appUrl)) {
      event.preventDefault()
      shell.openExternal(url)
    }
  })

  mainWindow.on("close", () => {
    app.exit(0)
 })
}

app.whenReady().then(() => {
  createWindow()
})

app.on('window-all-closed', function () {
  if (process.platform !== 'darwin') app.quit()
})
