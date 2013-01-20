/*
 *                            _/                                                    _/
 *       _/_/_/      _/_/    _/  _/    _/    _/_/_/    _/_/    _/_/_/      _/_/_/  _/
 *      _/    _/  _/    _/  _/  _/    _/  _/    _/  _/    _/  _/    _/  _/    _/  _/
 *     _/    _/  _/    _/  _/  _/    _/  _/    _/  _/    _/  _/    _/  _/    _/  _/
 *    _/_/_/      _/_/    _/    _/_/_/    _/_/_/    _/_/    _/    _/    _/_/_/  _/
 *   _/                            _/        _/
 *  _/                        _/_/      _/_/
 *
 * POLYGONAL - A HAXE LIBRARY FOR GAME DEVELOPERS
 * Copyright (c) 2009 Michael Baczynski, http://www.polygonal.de
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
package de.polygonal.core.util;

import haxe.macro.Context;
import haxe.macro.Expr;

class IntEnum
{
	#if haxe3 macro #else @:macro #end
	public static function build(e:Expr, bitFlags:Bool = false):Array<Field>
	{
		var pos = Context.currentPos();
		var fields = Context.getBuildFields();
		var i = 0;
		
		switch (e.expr)
		{
			case EArrayDecl(a):
				for (b in a)
				{
					switch (b.expr)
					{
						case EConst(c):
							switch (c)
							{
								case CIdent(d):
									
									var val = bitFlags ? (1 << i) : i;
									i++;
									
									fields.push({
										name: d,
										doc: null,
										meta: [],
										access: [AStatic, APublic, AInline],
										kind: FVar(TPath( { pack: [], name: 'Int', params: [], sub: null } ), { expr: EConst(CInt(Std.string(val))), pos: pos } ),
										pos: pos});
								default: Context.error('unsupported declaration', pos);
							}
						default: Context.error('unsupported declaration', pos);
					}
				}
			default: Context.error('unsupported declaration', pos);
		}
		
		return fields;
	}
}