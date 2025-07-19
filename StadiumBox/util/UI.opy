#!mainFile "../StadiumBox.opy"



macro eventPlayer.setResultText(text):

    if eventPlayer.StatsTextElement != null:
        destroyProgressBarHud(eventPlayer.StatsTextElement)
    
    createCasedProgressBarIwt(3, eventPlayer if not eventPlayer.isSampling() else null, text, vect(52.25, 2, 29), 1, Clip.SURFACES, Color.WHITE)
    eventPlayer.StatsTextElement = getLastCreatedText()

    # hudSubtext(eventPlayer, text, HudPosition.RIGHT, 0, Color.WHITE)
    # eventPlayer.StatsTextElements.append(getLastCreatedText())

    # if len(eventPlayer.StatsTextElements) > 3:
    #     destroyHudText(eventPlayer.StatsTextElements[0])
    #     del eventPlayer.StatsTextElements[0]


    #if eventPlayer.StatsTextElement != null:
    #    destroyProgressBarInWorldText(eventPlayer.StatsTextElement)

    #createCasedProgressBarIwt(3, eventPlayer if not eventPlayer.isSampling() else null, RESULT_TEXT.format(text), vect(57.75, 3, 32.25), 1, Clip.SURFACES, Color.WHITE)
    #createCasedProgressBarIwt(3, eventPlayer if not eventPlayer.isSampling() else null, text, null, 1)
    #hudSubtext(eventPlayer, text, HudPosition.RIGHT, 0, Color.WHITE)
    #eventPlayer.StatsTextElement = getLastCreatedText()