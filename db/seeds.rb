

ajp = Journal.create(title: "Australasian Journal of Philosophy")
analysis = Journal.create(title: "Analysis")
apq = Journal.create(title: "American Philosophical Quarterly")
bjps = Journal.create(title: "British Journal for the Philosophy of Science")
cjp = Journal.create(title: "Canadian Journal of Philosophy")
dialectica = Journal.create(title: "Dialectica")
erkenntnis = Journal.create(title: "Erkenntnis")
ethics = Journal.create(title: "Ethics")
ethicaltheoryandpractice = Journal.create(title: "Ethical Theory and Moral Practice")
nous = Journal.create(title: "Nous")
pacphil = Journal.create(title: "Pacific Philosophical Quarterly")
philstud = Journal.create(title: "Philosophical Studies")
ppr = Journal.create(title: "Philosophy and Phenomenological Research")
philimprint = Journal.create(title: "Philosophers' Imprint")
philquarterly = Journal.create(title: "Philosophical Quarterly")
ratio = Journal.create(title: "Ratio")
reviewpandp = Journal.create(title: "Review of Philosophy and Psychology")
synthese = Journal.create(title: "Synthese")
thought = Journal.create(title: "Thought")

user = User.create(name: "Derek Shiller", email: "Dcshiller@gmail.com", password: "password")

halfit = user.articles.create(title: "How to Half it Both Ways")
halfit.submissions.create(journal: synthese)
sub = halfit.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "30/08/2012".to_date)
sub.events.create(event_type: "decision", event_subtype: "revise & resubmit", date: "02/01/2013".to_date)
sub.events.create(event_type: "submission", event_subtype: "revision", date: "22/01/2013".to_date)
sub.events.create(event_type: "decision", event_subtype: "revise & resubmit", date: "24/06/2013".to_date)
sub.events.create(event_type: "submission", event_subtype: "revision", date: "28/06/2013".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "01/11/2013".to_date)
halfit.submissions.create(journal: philstud)
sub.events.create(event_type: "submission", event_subtype: "initial", date: "04/11/2013".to_date)
sub.events.create(event_type: "decision", event_subtype: "revise & resubmit", date: "13/06/2014".to_date)

primsol = user.articles.create(title: "A Primitive Solution to the Negation Problem")
primsol.submissions.create(journal: philimprint)
sub = primsol.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "06/11/2013".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "25/11/2013".to_date)

primsol.submissions.create(journal: ethics)
sub = primsol.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "19/12/2013".to_date)
sub.events.create(event_type: "submission", event_subtype: "revision", date: "21/02/2014".to_date)
sub.events.create(event_type: "decision", event_subtype: "revise & resubmit", date: "12/05/2014".to_date)
sub.events.create(event_type: "submission", event_subtype: "revision", date: "01/06/2014".to_date)
sub.events.create(event_type: "decision", event_subtype: "revise & resubmit", date: "09/07/2014".to_date)
sub.events.create(event_type: "submission", event_subtype: "revision", date: "26/07/2014".to_date)
sub.events.create(event_type: "decision", event_subtype: "revise & resubmit", date: "08/09/2014".to_date)
sub.events.create(event_type: "submission", event_subtype: "revision", date: "19/09/2014".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "05/11/2014".to_date)

primsol.submissions.create(journal: nous)
sub = primsol.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "14/11/2014".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "29/12/2014".to_date)

primsol.submissions.create(journal: philquarterly)
sub = primsol.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "01/01/2015".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "19/03/2015".to_date)

primsol.submissions.create(journal: ajp)
sub = primsol.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "05/04/2015".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "24/05/2015".to_date)

primsol.submissions.create(journal: ethicaltheoryandpractice)
sub = primsol.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "24/05/2015".to_date)
sub.events.create(event_type: "decision", event_subtype: "revision", date: "13/08/2015".to_date)
sub.events.create(event_type: "submission", event_subtype: "revision", date: "10/10/2015".to_date)
sub.events.create(event_type: "decision", event_subtype: "acceptance", date: "23/11/2015".to_date)

nofact = user.articles.create(title: "There is no fact of the matter whether it is wrong to hurt fish")
nofact.submissions.create(journal: philimprint)
sub = nofact.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "29/10/2013".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "09/12/2013".to_date)

nofact.submissions.create(journal: ppr)
sub = nofact.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "18/12/2013".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "03/01/2014".to_date)

nofact.submissions.create(journal: philquarterly)
sub = nofact.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "07/01/2014".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "29/01/2014".to_date)

nofact.submissions.create(journal: ajp)
sub = nofact.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "17/04/2014".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "21/07/2014".to_date)

hidqua = user.articles.create(title: "Hidden Qualia")
hidqua.submissions.create(journal: philimprint)
sub = hidqua.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "10/10/2014".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "31/10/2014".to_date)

hidqua.submissions.create(journal: philstud)
sub = hidqua.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "16/11/2014".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "06/04/2015".to_date)

hidqua.submissions.create(journal: reviewpandp)
sub = hidqua.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "24/04/2015".to_date)
sub.events.create(event_type: "decision", event_subtype: "conditional acceptance", date: "24/08/2015".to_date)
sub.events.create(event_type: "submission", event_subtype: "revision", date: "02/10/2015".to_date)
sub.events.create(event_type: "decision", event_subtype: "acceptance", date: "21/12/2015".to_date)

theprob = user.articles.create(title: "The Problem of Other Attitudes")
theprob.submissions.create(journal: analysis)
sub = theprob.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "29/12/2014".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "14/01/2015".to_date)

theprob.submissions.create(journal: thought)
sub = theprob.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "31/01/2015".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "23/03/2015".to_date)

theprob.submissions.create(journal: apq)
sub = theprob.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "24/04/2015".to_date)
sub.events.create(event_type: "decision", event_subtype: "revise & resubmit", date: "22/07/2015".to_date)
sub.events.create(event_type: "submission", event_subtype: "revision", date: "04/08/2015".to_date)
sub.events.create(event_type: "decision", event_subtype: "acceptance", date: "19/09/2015".to_date)

indiff = user.articles.create(title: "Indifference About Size")
indiff.submissions.create(journal: bjps)
sub = indiff.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "27/01/2015".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "05/02/2015".to_date)

indiff.submissions.create(journal: synthese)
sub = indiff.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "06/02/2015".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "24/03/2015".to_date)

indiff.submissions.create(journal: ratio)
sub = indiff.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "31/03/2015".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "19/06/2015".to_date)

bayVol = user.articles.create(title: "Bayesian Volunteerism")
bayVol.submissions.create(journal: synthese)
sub = bayVol.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "23/05/2015".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "04/08/2015".to_date)

bayVol.submissions.create(journal: erkenntnis)
sub = bayVol.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "06/08/2015".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "17/01/2016".to_date)

selfKnow = user.articles.create(title: "Epiphenomenalism and the Miracle of Self Knowledge")
selfKnow.submissions.create(journal: ratio)
sub = selfKnow.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "03/06/2016".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "21/06/2016".to_date)

selfKnow.submissions.create(journal: pacphil)
sub = selfKnow.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "26/06/2016".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "10/07/2016".to_date)

selfKnow.submissions.create(journal: cjp)
sub = selfKnow.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "12/07/2016".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "20/07/2016".to_date)

selfKnow.submissions.create(journal: dialectica)
sub = selfKnow.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "27/07/2016".to_date)
sub.events.create(event_type: "decision", event_subtype: "revise & resubmit", date: "02/03/2017".to_date)
sub.events.create(event_type: "submission", event_subtype: "revision", date: "05/02/2017".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "03/11/2017".to_date)

unityMorAt = user.articles.create(title: "The Unity of Moral Attitudes")
unityMorAt.submissions.create(journal: ajp)
sub = unityMorAt.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "19/03/2016".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "07/09/2016".to_date)

unityMorAt.submissions.create(journal: philstud)
sub = unityMorAt.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "10/10/2016".to_date)
sub.events.create(event_type: "decision", event_subtype: "rejection", date: "22/01/2017".to_date)

unityMorAt.submissions.create(journal: cjp)
sub = unityMorAt.submissions.last
sub.events.create(event_type: "submission", event_subtype: "initial", date: "25/03/2017".to_date)
sub.events.create(event_type: "decision", event_subtype: "conditional acceptance", date: "01/10/2017".to_date)
sub.events.create(event_type: "submission", event_subtype: "revision", date: "29/11/2017".to_date)
sub.events.create(event_type: "decision", event_subtype: "acceptance", date: "04/12/2017".to_date)
