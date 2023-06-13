Hooks:Register("BaseNetworkSessionOnEnteredLobby")
Hooks:PostHook(BaseNetworkSession, "on_entered_lobby", "BLT.BaseNetworkSession.on_entered_lobby", function()
	local local_peer = managers.network:session():local_peer()
	Hooks:Call("BaseNetworkSessionOnEnteredLobby", local_peer, local_peer:id())
end)

Hooks:Register("BaseNetworkSessionOnPeerEnteredLobby")
Hooks:PostHook(BaseNetworkSession, "on_peer_entered_lobby", "BLT.BaseNetworkSession.on_peer_entered_lobby", function(self, peer)
	Hooks:Call("BaseNetworkSessionOnPeerEnteredLobby", peer, peer:id())
end)

Hooks:Register("BaseNetworkSessionOnPeerRemoved")
Hooks:PostHook(BaseNetworkSession, "_on_peer_removed", "BLT.BaseNetworkSession._on_peer_removed", function(self, peer, peer_id, reason)
	Hooks:Call("BaseNetworkSessionOnPeerRemoved", peer, peer_id, reason)
end)

Hooks:Register("BaseNetworkSessionOnLoadComplete")
Hooks:PostHook(BaseNetworkSession, "on_load_complete", "BLT.BaseNetworkSession.on_load_complete", function()
	local local_peer = managers.network:session():local_peer()
	Hooks:Call("BaseNetworkSessionOnLoadComplete", local_peer, local_peer:id())
end)