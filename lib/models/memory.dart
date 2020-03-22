class Memory {
  static const operations = ['%', '/', 'x', '-', '+', '='];
  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  String _operation;
  String _value = '0';
  bool _wipeValue = false;
  String _lastCommand;

  void applyCommand(String command) {
    if (_isReplacingOperator(command)) {
      _operation = command;
      return;
    }

    if (command == "AC") {
      _clearAll();
    } else if (operations.contains(command)) {
      _setOperation(command);
    } else {
      _addDigit(command);
    }

    _lastCommand = command;
  }

  _setOperation(String newOperation) {
    bool wasEqualPressed = newOperation == '=';

    if (_bufferIndex == 0) {
      if (!wasEqualPressed) {
        _operation = newOperation;
        _bufferIndex = 1;
        _wipeValue = true;
      }
    } else {
      _buffer[0] = _calculate();
      _buffer[1] = 0.0;
      _value = _buffer[0].toString();
      _value = _value.endsWith('.0') ? _value.split('.')[0] : _value;

      _operation = wasEqualPressed ? null : newOperation;
      _bufferIndex = wasEqualPressed ? 0 : 1;
    }
    _wipeValue = !wasEqualPressed;
  }

  _addDigit(String digit) {
    final isDot = digit == '.';
    final isInitialValueZero = (_value == '0' && !isDot) || _wipeValue;

    if (isDot && _value.contains('.') && !isInitialValueZero) {
      return;
    }

    final emptyValue = isDot ? '0' : ''; //if user types dot after an operation

    final currentValue = isInitialValueZero ? emptyValue : _value;
    _value = currentValue + digit;
    _wipeValue = false;

    _buffer[_bufferIndex] = double.tryParse(_value) ??
        0; // converts to double, if not a valid double (not parsed), fill with zero
    // print(_buffer);
  }

  _clearAll() {
    _value = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    _operation = null;
    _bufferIndex = 0;
    _wipeValue = false;
  }

  _calculate() {
    switch (_operation) {
      case '%':
        return _buffer[0] % _buffer[1];
      case '/':
        return _buffer[0] / _buffer[1];
      case 'x':
        return _buffer[0] * _buffer[1];
      case '-':
        return _buffer[0] - _buffer[1];
      case '+':
        return _buffer[0] + _buffer[1];
      default:
        return _buffer[0];
    }
  }

  _isReplacingOperator(String command) {
    return operations.contains(_lastCommand) &&
        operations.contains(command) &&
        _lastCommand != '=' &&
        command != '=';
  }

  String get value {
    return _value;
  }
}
