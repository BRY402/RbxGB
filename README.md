# RbxGB

**RbxGB (Roblox Game Builder)** is a prototype for building and publishing Roblox games using pure XML. It is currently a proof of concept and will continue to improve over time.

## What is this?

RbxGB is a tool designed to publish Roblox games without requiring Roblox Studio. Its goal is to enable automated game creation and make game publishing accessible to users who cannot install or use Roblox Studio.

Unlike tools that simply generate Roblox XML, RbxGB aims to let you build and publish complete Roblox experiences entirely from Lua.

---

## ⚠️ Warning

This project interacts with Roblox's publishing APIs in automated ways. Depending on how it is used, Roblox may temporarily review your account or publishing activity.

For this reason, it is recommended to use an alternate account rather than your primary development account when using RbxGB.

Roblox also recommends using dedicated alternate accounts for projects that use Open Cloud API keys, as it helps isolate permissions and reduce risk. See the Roblox DevForum [announcement](https://devforum.roblox.com/t/deferred-api-key-consolidation-deprecating-group-owned-api-keys/4068530) for more information.

Always ensure your use of this tool complies with Roblox's Terms of Use and other applicable policies.

---

## Planned Features

As the project evolves, I plan to add features such as:

- Binary place publishing for improved compatibility.
- A more user-friendly syntax and API.
- Refactoring much of the prototype code into something more maintainable.

## Dependencies

- LuaSocket

```bash
luarocks install luasocket
```

> **Status:** This project is experimental and not yet intended for production use.