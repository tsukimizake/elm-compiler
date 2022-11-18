{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_elm (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,19,1] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/Users/tsukimizake/.cabal/bin"
libdir     = "/Users/tsukimizake/.cabal/lib/x86_64-osx-ghc-8.6.5/elm-0.19.1-inplace-elm"
dynlibdir  = "/Users/tsukimizake/.cabal/lib/x86_64-osx-ghc-8.6.5"
datadir    = "/Users/tsukimizake/.cabal/share/x86_64-osx-ghc-8.6.5/elm-0.19.1"
libexecdir = "/Users/tsukimizake/.cabal/libexec/x86_64-osx-ghc-8.6.5/elm-0.19.1"
sysconfdir = "/Users/tsukimizake/.cabal/etc"

getBinDir     = catchIO (getEnv "elm_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "elm_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "elm_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "elm_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "elm_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "elm_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
