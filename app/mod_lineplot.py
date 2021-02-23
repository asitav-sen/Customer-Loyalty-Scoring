def zewduplotlyline(x,y):
    fig = go.Figure()
    fig.add_trace(go.Scatter(
        x=x,
        y=y,
        name = '<b>No</b> Gaps',
        connectgaps=True 
    ))
    fig.show() 