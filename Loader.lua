local LoadScript = function(source_code, whitelist_key)
    whitelist_key = whitelist_key or "nono dont touch me there, thats thats, my nono square!!"

    local Script = string.format("if not getrenv().shared.require then end; script_key = '%s';", whitelist_key) .. source_code

    local DeletedActors = getdeletedactors and getdeletedactors()
    local ActorThreads = getactorthreads and getactorthreads()
    local Actors = getactors and getactors()

    if run_on_actor then
        if #Actors > 0 then
            for _, actor in Actors do
                run_on_actor(actor, Script)
            end
        elseif #DeletedActors > 0 then
            for _, actor in DeletedActors do
                run_on_actor(actor, Script)
            end
        end
    elseif run_on_thread and #ActorThreads > 0 then
        for _, actor_thread in ActorThreads do 
            run_on_thread(actor_thread, Script)
        end
    else
        --[[ NOTE:
    `       In order to load scripts that retrieve modules you will need these functions:
            getrenv (FULLY FUNCTIONAL, a lot of executors fail to get the proper shared table)
            getconnections (Only required for some scripts, PF Haxx, and possibly more)
            debug library (Required for accessing upvalues, constants, and etc)
        ]]

        loadstring(Script)()
    end
end

return LoadScript
