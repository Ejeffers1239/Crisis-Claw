--Crisis Claw - Deciet
--Ejeffers1239
function c84508305.initial_effect(c)
	--reveal and add/send (untested, and also probably no way this works)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84508305,0))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,84508305)
	e1:SetTarget(c84508305.target)
	e1:SetOperation(c84508305.activate)
	c:RegisterEffect(e1)
	--Banish to set an equip (untested, also probably doesn't work lol)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(84508305,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,84508305 + 1)
	e2:SetTarget(c84508305.bantg)
	e2:SetCost(aux.bfgcost)
	e2:SetOperation(c84508305.banop)
	c:RegisterEffect(e2)
end
--eff 1
function c84508305.thfilter(c,tp)
	return c:IsSetCard(0x867) and c:IsAbleToHand() and c:IsAbleToGrave()
end

function c84508305.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c84508305.thfilter,tp,LOCATION_DECK,0,nil,tp)
	if chk==0 then return g:GetClassCount(Card.GetCode)>=2 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c84508305.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c84508305.thfilter,tp,LOCATION_DECK,0,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=g:SelectSubGroup(tp,aux.dncheck,false,2,2)
	if sg then
		Duel.ConfirmCards(1-tp,sg)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local oc=sg:Select(1-tp,1,1,nil):GetFirst()
		Duel.SendtoHand(oc,tp,REASON_EFFECT)~=0
		sg:RemoveCard(oc)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sc=sg:Select(tp,1,1,nil):GetFirst()
		Duel.SendtoGrave(sc,tp,REASON_EFFECT)
	
	end
end
--eff 2

function c84508305.setfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsType(TYPE_EQUIP) and c:IsSetCard(0x867) and c:IsSSetable()
end

function c84508305.bantg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then
		return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c84508305.setfilter(chkc)
	end
	if chk==0 then 
		return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.IsExistingTarget(c84508305.setfilter,tp,LOCATION_GRAVE,0,1,nil)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectTarget(tp,c84508305.setfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end

function c84508305.setop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SSet(tp,tc)
	end