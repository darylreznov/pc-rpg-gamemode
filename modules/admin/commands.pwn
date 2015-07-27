/*******************************************************************************
* FILENAME :        modules/admin/commands.pwn
*
* DESCRIPTION :
*       Adds admins commands to the server.
*
* NOTES :
*       This file should only contain admin data.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

/***
 *
 *       ##   #####  #    # # #    # #  ####  ##### #####    ##   #####  ####  #####
 *      #  #  #    # ##  ## # ##   # # #        #   #    #  #  #    #   #    # #    #
 *     #    # #    # # ## # # # #  # #  ####    #   #    # #    #   #   #    # #    #
 *     ###### #    # #    # # #  # # #      #   #   #####  ######   #   #    # #####
 *     #    # #    # #    # # #   ## # #    #   #   #   #  #    #   #   #    # #   #
 *     #    # #####  #    # # #    # #  ####    #   #    # #    #   #    ####  #    #
 *
 ***/

YCMD:criarcar(playerid, params[], help)
{
    if(GetPlayerHighestRank(playerid) < PLAYER_RANK_ADMIN)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    new
		idx,
		iString[ 128 ];

	if ( params[ 0 ] == '\0' )
		return SendClientMessage( playerid, COLOR_INFO, "* /criarcar [modeloid/nome]" );

	idx = GetVehicleModelIDFromName( params );

	if( idx == -1 )
	{
		idx = strval(iString);

		if ( idx < 400 || idx > 611 )
			return SendClientMessage(playerid, COLOR_ERROR, "* Veículo inválido.");
	}

	new	Float:x, Float:y, Float:z, Float:a;
	GetPlayerPos(playerid, x, y, z);
	GetXYInFrontOfPlayer(playerid, x, y, 5.0);
	GetPlayerFacingAngle(playerid, a);

	new vehicleid = CreateVehicle(idx, x, y, z + 2.0, a + 90.0, -1, -1, 5000);
	LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
    SetVehicleFuel(vehicleid, 100.0);

    format(iString, 128, "* Você criou um \"%s\" (ModeloID: %d, VeículoID: %d)", aVehicleNames[idx - 400], idx, vehicleid);
	SendClientMessage(playerid, COLOR_SUCCESS, iString);
    return 1;
}

/***
 *
 *     #####  ###### #    # ###### #       ####  #####  ###### #####
 *     #    # #      #    # #      #      #    # #    # #      #    #
 *     #    # #####  #    # #####  #      #    # #    # #####  #    #
 *     #    # #      #    # #      #      #    # #####  #      #####
 *     #    # #       #  #  #      #      #    # #      #      #   #
 *     #####  ######   ##   ###### ######  ####  #      ###### #    #
 *
 */

YCMD:setrank(playerid, params[], help)
{
	if(IsPlayerAdmin(playerid) || GetPlayerHighestRank(playerid) == PLAYER_RANK_DEVELOPER)
	{
		new	targetid, rankName[9], option[8];
		if(sscanf(params, "us[9]s[8]", targetid, rankName, option))
        {
			SendClientMessage(playerid, COLOR_INFO, "* /setrank [playerid] [nome do rank] [add / remover]");
			SendClientMessage(playerid, COLOR_WHITE, "* Ranks: donator, designer, beta, mod, super, admin, dev");
        }
        else
        {
            if(!strcmp(rankName, "donator", true))
            {
                if(!strcmp(option, "add", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você adicinou %s ao cargo donator.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_DONATOR, targetid, true);
                }
                else if(!strcmp(option, "remover", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você removeu %s do cargo donator.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_DONATOR, targetid, false);
                }
                else SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
            }
            else if(!strcmp(rankName, "designer", true))
            {
                if(!strcmp(option, "add", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você adicinou %s ao cargo designer.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_DESIGNER, targetid, true);
                }
                else if(!strcmp(option, "remover", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você removeu %s do cargo designer.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_DESIGNER, targetid, false);
                }
                else SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
            }
            else if(!strcmp(rankName, "beta", true))
            {
                if(!strcmp(option, "add", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você adicinou %s ao cargo beta.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_BETATESTER, targetid, true);
                }
                else if(!strcmp(option, "remover", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você removeu %s do cargo beta.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_BETATESTER, targetid, false);
                }
                else SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
            }
            else if(!strcmp(rankName, "mod", true))
            {
                if(!strcmp(option, "add", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você adicinou %s ao cargo moderador.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_MODERATOR, targetid, true);
                }
                else if(!strcmp(option, "remover", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você removeu %s do cargo moderador.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_MODERATOR, targetid, false);
                }
                else SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
            }
            else if(!strcmp(rankName, "super", true))
            {
                if(!strcmp(option, "add", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você adicinou %s ao cargo supervisor.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_SUPERVISOR, targetid, true);
                }
                else if(!strcmp(option, "remover", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você removeu %s do cargo supervisor.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_SUPERVISOR, targetid, false);
                }
                else SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
            }
            else if(!strcmp(rankName, "admin", true))
            {
                if(!strcmp(option, "add", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você adicinou %s ao cargo admin.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_ADMIN, targetid, true);
                }
                else if(!strcmp(option, "remover", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você removeu %s do cargo admin.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_ADMIN, targetid, false);
                }
                else SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
            }
            else if(!strcmp(rankName, "dev", true))
            {
                if(!strcmp(option, "add", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você adicinou %s ao cargo dev.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_DEVELOPER, targetid, true);
                }
                else if(!strcmp(option, "remover", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você removeu %s do cargo dev.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_DEVELOPER, targetid, false);
                }
                else SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
            }
        }
    }
	else SendClientMessage(playerid, COLOR_ERROR, "Você não tem permissão.");
	return 1;
}