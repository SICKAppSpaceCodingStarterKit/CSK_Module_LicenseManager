--MIT License
--
--Copyright (c) 2023 SICK AG
--
--Permission is hereby granted, free of charge, to any person obtaining a copy
--of this software and associated documentation files (the "Software"), to deal
--in the Software without restriction, including without limitation the rights
--to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--copies of the Software, and to permit persons to whom the Software is
--furnished to do so, subject to the following conditions:
--
--The above copyright notice and this permission notice shall be included in all
--copies or substantial portions of the Software.
--
--THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
--SOFTWARE.

---@diagnostic disable: undefined-global, redundant-parameter, missing-parameter
--**************************************************************************
--**********************Start Global Scope *********************************
--**************************************************************************

Script.serveEvent('CSK_Module_LicenseManager.OnNewStatusCSKStyle', 'LicenseManager_OnNewStatusCSKStyle')

-- Timer to update UI via events after page was loaded
local tmr = Timer.create()
tmr:setExpirationTime(100)
tmr:setPeriodic(false)

local licenseManager_Model = {}
licenseManager_Model.styleForUI = 'None' -- Optional parameter to set UI style

--**************************************************************************
--********************** End Global Scope **********************************
--**************************************************************************
--**********************Start Function Scope *******************************
--**************************************************************************

--- Function to send all relevant values to UI on resume
local function handleOnExpired()
  Script.notifyEvent("LicenseManager_OnNewStatusCSKStyle", licenseManager_Model.styleForUI)
end
Timer.register(tmr, 'OnExpired', handleOnExpired)

--- Function to react on UI style change
local function handleOnStyleChanged(theme)
  licenseManager_Model.styleForUI = theme
  Script.notifyEvent("LicenseManager_OnNewStatusCSKStyle", licenseManager_Model.styleForUI)
end
Script.register('CSK_PersistentData.OnNewStatusCSKStyle', handleOnStyleChanged)

local function pageCalled()
  tmr:start()
  return ''
end
Script.serveFunction("CSK_Module_LicenseManager.pageCalled", pageCalled)