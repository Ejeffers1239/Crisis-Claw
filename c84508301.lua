--Crisis Claw - Corruption
--Ejeffers1239
function c84508301.initial_effect(c)
	--"Stratos" effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84508301,0))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,84508301)
	e1:SetTarget(c84508301.thtg)
	e1:SetOperation(c84508301.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--Banish From GY efffect
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(84508301,1))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,84508301)
	e3:SetTarget(c84508301.bantg)
	e3:SetCost(aux.bfgcost)
	e3:SetOperation(c84508301.banop)
	c:RegisterEffect(e1)
	end
	
function c84508301.thfilter(c)
	return c:IsSetCard(0x867) and c:IsType(TYPE_MONSTER) and not c:IsCode(84508301) and c:IsAbleToHand()
end

function c84508301.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c84508301.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end

function c84508301.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c84508301.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end