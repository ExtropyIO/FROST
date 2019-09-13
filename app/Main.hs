{- This file is part of the Haskell version of the FROST compiler.

   Copyright (C) 2019  XAIN Stichting, Amsterdam  info@xain.foundation

   The Haskell version of the FROST compiler is free software: you can
   redistribute it and/or modify it under the terms of the GNU General Public
   License as published by the Free Software Foundation, either version 3 of the
   License, or (at your option) any later version.

   The Haskell version of the FROST compiler is distributed in the hope that it
   will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
   Public License for more details.

   You should have received a copy of the GNU General Public License along with
   this program. If not, see <https://www.gnu.org/licenses/>.
-}

module Main where

import Lang
import Parser
import CmdOptions
import Text.Megaparsec (parseMaybe)
import Options.Applicative (execParser, info, (<**>), helper, fullDesc,
                            progDesc, header)


main :: IO ()
main = compFrost =<< execParser args
  where
    args = info (opts <**> helper)
      (  fullDesc
      <> progDesc "Synthesize a circuit-pair from a policy EXPRESSION or INFILE"
      <> header "frostc - a compiler for FROST" )

compFrost :: Opts -> IO ()
compFrost opts@(Opts (FileIn file) pp noOut out) = do
  expr <- readFile file
  -- NOTE char encoding is system / environment dependent! if this is a problem
  -- in the future consider suggestion in
  -- https://www.snoyman.com/blog/2016/12/beware-of-readfile
  compFrost (opts { source = ExprIn expr })
compFrost (Opts (ExprIn expr) True True _) =
  case parseMaybe frostParser expr of
    Nothing -> return () -- TODO error handling
    Just p  -> penc (compile0 p)
compFrost (Opts (ExprIn expr) pp False fp) =
  case parseMaybe frostParser expr of
    Nothing -> return ()
    Just p  -> if pp
               then encodeFilePretty fp (compile0 p)
               else encodeFile       fp (compile0 p)
compFrost _ = return ()
