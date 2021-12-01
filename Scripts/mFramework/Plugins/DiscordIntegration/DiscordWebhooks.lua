local Object = require('Object')
local WebClient = require('WebClient')

--- Discord(url) Create a DiscordClient Object for the Provided WebHook URL
---@param url string WebHook url
---@return table DiscordClient Object
local mDiscordClient = Object:extend()

function mDiscordClient:new(url)
    if not type(url) == 'string' then return nil end
    self.WebClient = WebClient(url)
end

--- Send a Message using this this DiscordClient Webhook
---@param name string this is the name shown as sender in discord
---@param msg string the message to send
---@param cb function a function to run after message has sent
function mDiscordClient:SendMessage(name, msg, cb)
    req = {Body = {username = name, content = msg}}
    -- we dont care about any result. we should probably at least check it was succcessfull , but that would require postAsync and that uses timers and coroutines
    --- this webhook call is pretty dumb, as long as you pass valid info it should just work. if we can, just do this sync:: wontfix unless urgeant.
    self.WebClient:post(req, cb)
end

--- Load any Channels from Config and Create a DiscordClient for Each.
mFramework.Discord = {Channels = {}}
local DiscordChannels = mFramework.Config['DiscordChannels']
if type(DiscordChannels) == 'table' then
    for ChannelName, ChannelURI in pairs(DiscordChannels) do
        --[[ Channels are defined in the config like
            [DiscordChannels]
            ChannelNameNoSpacesOrSymbols='webhookurl'
            ChannelNameNoSpaces2='webhookurl'
        ]]
        mFramework.Discord.Channels[ChannelName] = mDiscordClient(ChannelURI)
    end
end

Script.LoadScriptFolder("Scripts/mFramework/Plugins/DiscordIntegration/ChatCommands")