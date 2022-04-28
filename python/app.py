from flask import Flask
from .sim.mc import Simulator

app = Flask(__name__)

@app.route('/')
def index():
    return 'Simulator for Insight!'

@app.route('/sim')
def serve_mc_sim():
    s = Simulator()
    rho, penalty = s.get_liquidation_ratio(), s.get_liquidation_penalty()
    return {
        'liquidation_ratio': rho,
        'liquidation_penalty': penalty
    }

app.run(host='0.0.0.0', port=5000)