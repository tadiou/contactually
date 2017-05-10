class FilterButton extends React.Component {
  render () {
    return (
      <button onClick={this.props.action}>{this.props.name}</button>  
    )
  }
}
