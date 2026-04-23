/*
**  Written by MtgCore
**  Rewritten by Poszer & Talamortis https://github.com/poszer/ & https://github.com/talamortis/
**  AzerothCore +2019 http://www.azerothcore.org/
**  Cleaned and made into a module by Micrah https://github.com/milestorme/
*/

#include "npc_services.h"
#include "Chat.h"

bool NpcServices::OnGossipHello(Player* player, Creature* creature)
{
    // Reset Instances
    AddGossipItemFor(player, 10, "|TInterface\\icons\\Achievement_BG_winAB_underXminutes:40:40:-18|t Reset Instances", GOSSIP_SENDER_MAIN, 1);
    // Open Bank
    AddGossipItemFor(player, 10, "|TInterface/Icons/INV_Misc_Bag_07:40:40:-18|t Bank", GOSSIP_SENDER_MAIN, 2);
    // Open Mailbox
    AddGossipItemFor(player, 10, "|TInterface/Icons/INV_Letter_11:40:40:-18|t Mail", GOSSIP_SENDER_MAIN, 3);

    SendGossipMenuFor(player, 1, creature->GetGUID());
    return true;
}

bool NpcServices::OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action)
{
    player->PlayerTalkClass->ClearMenus();

    switch (action)
    {
        case 1: // Reset Instances
        {
            CloseGossipMenuFor(player);
            uint32 diff = 2;

            std::vector<Player*> members;
            members.push_back(player);

            Group* group = player->GetGroup();
            if (group)
            {
                for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
                {
                    Player* member = itr->GetSource();
                    if (member)
                    {
                        members.push_back(member);
                    }
                }
            }

            for (uint8 i = 0; i < diff; ++i)
            {
                for (uint8 j = 0; j < members.size(); ++j)
                {
                    Player* member = members[j];
                    BoundInstancesMap const& m_boundInstances = sInstanceSaveMgr->PlayerGetBoundInstances(member->GetGUID(), Difficulty(i));
                    for (BoundInstancesMap::const_iterator itr = m_boundInstances.begin(); itr != m_boundInstances.end();)
                    {
                        if (itr->first != member->GetMapId())
                        {
                            sInstanceSaveMgr->PlayerUnbindInstance(member->GetGUID(), itr->first, Difficulty(i), true, member);
                            itr = m_boundInstances.begin();
                        }
                        else
                            ++itr;
                    }
                }
            }

            ChatHandler(player->GetSession()).SendNotification("|cffFFFFFFInstances reseted!");
            player->CastSpell(player, 59908);
            return true;
        }

        case 2:	// BANK
            CloseGossipMenuFor(player);
            player->GetSession()->SendShowBank(player->GetGUID());
            break;

        case 3: // MAIL
            CloseGossipMenuFor(player);
            player->GetSession()->SendShowMailBox(player->GetGUID());
            break;
    }
    return true;
}
