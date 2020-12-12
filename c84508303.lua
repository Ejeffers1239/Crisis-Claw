--Crisis Claw - Hate
--Ejeffers1239
function c84508303.initial_effect(c)
	--literally doyon@ignister effect (untested)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84508303,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,84508303)
	e1:SetTarget(c84508303.thtg)
	e1:SetOperation(c84508303.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--Shaddoll Dragon Effect (untested)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(84508303,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,84508303)
	e3:SetCondition(c84508303.descon)
	e3:SetTarget(c84508303.destg)
	e3:SetOperation(c84508303.desop)
	c:RegisterEffect(e3)
end

--eff 1
function c84508303.thfilter(c)
	return c:IsSetCard(0x867) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end

function c84508303.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then 
		return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c84508303.thfilter1(chkc)
	end
	if chk==0 then
		return Duel.IsExistingTarget(c84508303.thfilter,tp,LOCATION_GRAVE,0,1,nil)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c84508303.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c84508303.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
--eff 2
function c84508303.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_EFFECT) and re and re:GetHandler():IsSetCard(0x867)
end	

function c84508303.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end

function c84508303.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c84508303.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c84508303.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c84508303.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end

function c84508303.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end