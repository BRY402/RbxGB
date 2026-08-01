local XML_ESCAPES = {
    ["&"] = "&amp;",
    ["<"] = "&lt;",
    [">"] = "&gt;",
    ['"'] = "&quot;",
    ["'"] = "&apos;",
}

return function(str)
    return (tostring(str):gsub("[&<>\'\"]", XML_ESCAPES))
end