var UserBox = React.createClass({
    getInitialState: function() {
        return {data: []};
    },

    componentDidMount: function() {
        $.ajax({
            url: this.props.url,
            dataType: 'json',
            success: function(data) {
                this.setState({data: data});
            }.bind(this),
            error: function(xhr, status, err) {
                console.error(this.props.url, status, err.toString());
            }.bind(this)
        });
    },

    handleFormSubmit: function(user) {
        $.ajax({
            url: this.props.url,
            dataType: 'json',
            type: 'POST',
            data: user,
            success: function(data) {
                console.log(data);
                this.setState({data: data});
            }.bind(this),
            error: function(xhr, status, err) {
                console.error(this.props.url, status, err.toString());
            }.bind(this)
        });
    },

    render: function() {
        return (
                <div className="peopleBox">
                <h1>Users</h1>
                <UserList data={this.state.data} />
                <UserForm onFormSubmit={this.handleFormSubmit} />
                </div>
        );
    }
});

var UserList = React.createClass({
  render: function() {
      console.log("user list render");
      console.log(this.props.data);
      var userNodes = this.props.data.map(function (user) {
          return (
                  <User name={user.name} />
          );
      });
      return (
              <div className="userList">
              {userNodes}
              </div>
      );
  }
});

var UserForm = React.createClass({
    handleSubmit: function(e) {
        e.preventDefault();
        var name = this.refs.name.getDOMNode().value.trim();
        if (!name) {
            return;
        }
        this.props.onFormSubmit({name: name});
        this.refs.name.getDOMNode().value = '';
    },
    render: function() {
        return (
                <div className="userForm">
                <form method="post" onSubmit={this.handleSubmit}>
                <input type="text" placeholder="Name..." ref="name" />
                <input type="submit" />
                </form>
                </div>
        );
    }
});

var User = React.createClass({
    render: function() {
        return (
            <div>
                <strong>
                {this.props.name}
                </strong>
                {this.props.children}
            </div>
        );
    }
});

var data = [
    {name: "tosh"},
    {name: "Jordan Walke"}
];

React.render(
        <UserBox url="dbtest.json" />,
        document.getElementById('content')
);
