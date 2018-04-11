import React from 'react';
import axios from 'axios';
import {BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend} from 'recharts';

const colors = [
  '#8884d8',
  '#93FD93',
  '#2493FD',
  '#FF00DD',
  '#DD00FF',
  '#00FFD3',
  '#1279D0',
  '#D01279',
  '#939393'
]

class CityCost extends React.Component {
  state = { cities: [] }

  componentDidMount() {
    axios.get('/api/properties/city_cost')
      .then( res => this.setState({ cities: res.data }) )
  }

  calcAvg = (prices, price) => {
    let sum = prices.split(', ').reduce( (total, num) => {
      return parseFloat(num) + total;
    }, 0);


    return sum / price
  }

  data = () => {
    let { cities } = this.state;
    return cities.map( city => {
      let key = city.city;
      let avg = this.calcAvg(city.prices, city.price);
      return {
        name: key,
        [key]: avg,
        amt: avg
      }
    });
  }

  render() {
    let { cities } = this.state;
    return (
      <BarChart 
        width={600} 
        height={300} 
        data={cities.length ? this.data() : []}
        margin={{top: 5, right: 30, left: 20, bottom: 5}}
        barGap={0}
      >
      <XAxis dataKey="name" />
      <YAxis />
      <CartesianGrid strokeDasharray="3 3" />
      <Tooltip />
      <Legend />
      { cities.map( (city, i) =>
          <Bar key={city.city} dataKey={city.city} fill={colors[i]}/>
        )
      }
      </BarChart>
    )
  }

}

export default CityCost;
