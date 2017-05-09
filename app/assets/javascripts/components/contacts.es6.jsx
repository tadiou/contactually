class Contacts extends React.Component {
  constructor () {
    super();
    this.state = { contacts: [] }
  }

  render () {
    return (
      <div className="table">
        <div className="row"> {this.headerList()} </div>
        {this.contactsList()}
      </div>
    );
  }

  componentDidMount () {
    $.get('api/v1/contacts', (data) => { this.setState({ contacts: data }) });
  }
  
  contactsList () {
    return this.state.contacts.map((contact, index) => {
      return <Contact key={index} contact={contact} />;
    });
  }

  headerList () {
    return ['First Name', 'Last Name', 'Email', 'Phone Number', 'Extension', 'Company Name'].map((header, index) => {
      return <div className='column header' key={index}>{header}</div>;
    });
  }
}

