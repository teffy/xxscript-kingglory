------------------------------------------------------------
--@desc XX UI 控件封装
--@author teffy
--@github https://github.com/teffy/xxscript-kingglory
------------------------------------------------------------
require("tflibs.UIAdapter")
local uuid = require("tflibs.uuid")
uuid.seed()

-- style表示界面样式，目前支持两种：
-- 1.default 控件垂直排列
-- 2.custom 界面中所有控件都必须设置大小和位置
ViewStyle = {
  DEFAULT = "default",
  CUSTOM = "custom"
}

-- 对齐方式
TextAlign = {
  LEFT = "left",
  CENTER = "center",
  RIGHT = "right"
}

-- LinearLayout 对齐方式
VAlign = {
  TOP = "top",
  CENTER = "center",
  BOTTOM = "bottom"
}

KBtype = {
  DEFAULT = 'default',
  NUMBER = 'number',
  ASCII = 'ascii'
}

Orientation  = {
  VERTICAL = 'vertical',
  HORIZONTAL = 'horizontal',
} 

local function has_value(tab, val)
  for index, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

local viewIds = {}
local addedViewIds = {}

-- 创建View对象
local function createView(options, mematable)
  if mematable == nil then
    error("View type missing")
  end
  options = options or {}

  if options.id == nil then
    options.id = uuid()
  end
  if has_value(viewIds, options.id) then
    print(viewIds)
    error("view id must be unique:" .. options.id)
  else
    table.insert(viewIds, options.id)
  end
  -- print(viewIds)

  for k, v in pairs(mematable) do
    if k ~= "__index" and type(v) ~= "function" and options[k] == nil then
      options[k] = v
    end
  end
  setmetatable(options, mematable)
  mematable.__index = mematable
  options.setRect = function(self, left, top, width, height)
    options.rect = string.format("%d, %d, %d, %d", left, top, width, height)
  end
  return options
end

-- 设置选项
-- @param view 目标view
-- @param ... 选项
local function setList(view, ...)
  local list_value = ""
  local args = {...}
  for i, v in pairs(args) do
    if i == #args then
      list_value = list_value .. v
    else
      list_value = list_value .. v .. ","
    end
  end
  view.list = list_value
end

-- 设置选择项
-- @param view 目标view
-- @param ... 选择项，数字
local function setSelects(view, ...)
  local select_value = ""
  local args = {...}
  for i, v in pairs(args) do
    if i == #args then
      select_value = select_value .. v
    else
      select_value = select_value .. v .. "@"
    end
  end
  view.select = select_value
end

-- 检查 options 参数是否是 table 或者 nil
local function checkOptions(options)
  optionsType = type(options)
  if optionsType ~= "table" and optionsType ~= "nil" then
    error("options must be table or nil")
  end
end

-- 检查view是否已经添加过了，因为id唯一，不能重复使用这个view
local function checkViewIsAdded(view)
  if view == nil then
    error("view is nil,can not be added")
  end
  if has_value(addedViewIds, view.id) then
    error("view has been added :" .. view.id)
  else
    table.insert(addedViewIds, view.id)
  end
end

-- 根据删除 addedViewIds 中的id
local function removeAddedId(id)
  for i = 1, #addedViewIds do
    if addedViewIds[i] == id then
      table.remove(addedViewIds, i)
      break
    end
  end
end

local function removeView(parent, view)
  if view == nil then
    error("view is nil,can not be removed")
  end
  if view then
    for i = 1, #parent.views do
      if parent.views[i] == view then
        table.remove(parent.views, i)
        removeAddedId(view.id)
        break
      end
    end
  end
end

local function removeViewByID(parent, id)
  if view == nil then
    error("view is nil,can not be removed")
  end
  if view then
    for i = 1, #parent.views do
      if parent.views[i].id == id then
        table.remove(parent.views, i)
        removeAddedId(id)
      end
    end
  end
end

-- 根View
RootView = {
  style = ViewStyle.DEFAULT,
  width = 600,
  height = 450,
  cancelname = "Cancel",
  okname = "OK",
  cancelscroll = true,
  views = {},
  countdown = -1
  -- 倒计时，-1，则一直停留，大于0会倒计时
}

-- 创建根View
function RootView:create(options)
  checkOptions(options)
  options = options or {}
  options.views = {}
  return createView(options, RootView)
end

function RootView:addView(view)
  checkViewIsAdded(view)
  table.insert(self.views, view)
  -- 判断已添加view中是否有 page，如果有 page，则同级控件都就只能是 page
  hasPageAndOther = function()
    local hasPage = false
    local hasOther = false
    for i, v in pairs(self.views) do
      if v.type == Page.type then
        hasPage = true
      else
        hasOther = true
      end
    end
    return hasPage and hasOther
  end
  if hasPageAndOther() then
    error("RootView only has all pages or all other views")
  end
end

-- 调用系统 showUI 并返回结果
function RootView:showUI()
  -- 自动适配
  return showUI(UIAdapter:adapterUI(self))
end

-- Lable
Label = {
  id = "LabelID",
  type = "Label",
  text = "LabelText",
  size = 30,
  align = TextAlign.LEFT,
  color = "0, 0, 0",
  bg = '255,255,255',
  -- extra = {}

--   {
--     "color" : "100,110,200",
--     "extra" : [          //附加属性指定
--        {
--           "goto" : "http://www.baidu.com",       //跳转到网址
--           "text" : "阅读原文"
--        },
--        {
--           "goto" : "qq",     //跳转到QQ咨询
--           "text" : "1602127440"
--        }
--     ],
--     "size" : 30,
--     "text" : "阅读原文 QQ:1602127440",
--     "type" : "Label"
--  }
  -- 支持多种类型的跳转 goto，对应跳转类型的属性类别为url、qq；跳转网址 url：属性类别中直接输入该url； 跳转QQ：属性类别填写"qq"。
}

-- 创建Lable
function Label:create(options)
  checkOptions(options)
  return createView(options, Label)
end

function Label:addExtra(goto,text)
  if self.extra == nil then
    self.extra = {}
  end
  table.insert(self.extra,{
    goto=goto,
    text=text
  })
end

-- RadioGroup
RadioGroup = {
  id = "RadioGroupID",
  type = "RadioGroup",
  list = "op1, op2, op3",
  select = "1@2",
  orientation = Orientation.VERTICAL
}

function RadioGroup:create(options)
  checkOptions(options)
  return createView(options, RadioGroup)
end

function RadioGroup:setList(...)
  setList(self, ...)
end

function RadioGroup:setSelect(n)
  self.select = tostring(n)
end

-- Edit
Edit = {
  id = "EditID",
  type = "Edit",
  prompt = "prompt",
  align = TextAlign.LEFT,
  kbtype = KBtype.NUMBER,
  size = 25,
  text = "这是预输入文本",
  color = "0,0,0"
}

function Edit:create(options)
  checkOptions(options)
  return createView(options, Edit)
end

-- CheckBoxGroup
CheckBoxGroup = {
  id = "CheckBoxGroupID",
  type = "CheckBoxGroup",
  list = "op1, op2, op3",
  select = "1@2",
  orientation = Orientation.VERTICAL
}

function CheckBoxGroup:create(options)
  checkOptions(options)
  return createView(options, CheckBoxGroup)
end

function CheckBoxGroup:setList(...)
  setList(self, ...)
end

function CheckBoxGroup:setSelects(...)
  setSelects(self, ...)
end

--Image
Image = {
  id = "ImageID",
  type = "Image"
}

function Image:create(options)
  checkOptions(options)
  return createView(options, Image)
end

function Image:setSrc(src)
  self.src = tostring(src)
end

-- ComboBox
ComboBox = {
  id = "ComboBoxId",
  list = "op1,op2",
  select = "1",
  size = 30,
  type = "ComboBox"
}

function ComboBox:create(options)
  checkOptions(options)
  return createView(options, ComboBox)
end

function ComboBox:setList(...)
  setList(self, ...)
end

function ComboBox:setSelects(...)
  setSelects(self, ...)
end

-- Page
Page = {
  id = "PageID",
  type = "Page",
  text = "PageView0",
  views = {}
}

-- 创建Page
function Page:create(options)
  checkOptions(options)
  options = options or {}
  options.views = {}
  return createView(options, Page)
end

-- 添加子View
function Page:addView(view)
  checkViewIsAdded(view)
  if view and view.type ~= self.type then
    table.insert(self.views, view)
  else
    error("page can not be added into page")
  end
end

-- 删除子View
function Page:removeView(view)
  removeView(self, view)
end

function Page:removeViewByID(id)
  removeViewByID(self, id)
end

-- LinearLayout
LinearLayout = {
  id = "LinearLayoutID",
  width = 1780,
  height = 600,
  type = "LinearLayout",
  valign = VAlign.TOP,
  views = {}
}

function LinearLayout:create(options)
  checkOptions(options)
  options = options or {}
  options.views = {}
  return createView(options, LinearLayout)
end

-- 添加子View
function LinearLayout:addView(view)
  checkViewIsAdded(view)
  if view and view.type ~= Page.type and view.type ~= LinearLayout.type then
    table.insert(self.views, view)
  else
    error("Page or LinearLayout can not be added into page")
  end
end

-- 删除子View
function LinearLayout:removeView(view)
  removeView(self, view)
end

function LinearLayout:removeViewByID(id)
  removeViewByID(self, id)
end

-- WebView
WebView = {
  id = "WebViewID",
  -- url = ""
  type = "WebView",
  width = 800,
  height = 500
}

function WebView:create(options)
  checkOptions(options)
  return createView(options,WebView)
end

-- Line
Line = {
  id = "LineID",
  type = "Line",
  color = "0,0,0",
  width = 600,
  height = 4
}

function Line:create(options)
  checkOptions(options)
  return createView(options,Line)
end
