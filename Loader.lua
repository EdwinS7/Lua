-- NOTE: Phantom Forces destorys the actor upon the game loading.
-- NOTE: Exploits like Argon, and Swift both wont work since they search for the Actors instance.

local LoadScript = function(source_code, whitelist_key)
    whitelist_key = whitelist_key or "nono dont touch me there, thats thats, my nono square!!"

    local Script = string.format([[
        if not getrenv().shared.require then
            return
        end
        
        script_key = '%s';
    ]], whitelist_key) .. source_code

    local GetActors = getactorthreads or getdeletedactors or getactors
    local RunOnParallel = run_on_thread or run_on_actor

    if GetActors and #GetActors() > 0 then
        for _, actor in GetActors() do
            RunOnParallel(actor, Script)
        end
    end
end

return LoadScript
